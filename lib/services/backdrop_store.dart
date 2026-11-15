import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../storage/prefs_manager.dart';

/// What sits behind the app's glass cards.
enum BackdropKind {
  /// The theme's own glow.
  theme,

  /// One flat colour.
  solid,

  /// Two colours, top-left to bottom-right.
  linear,

  /// Soft blobs of both colours over the darker one.
  mesh,

  /// The person's own photo.
  photo,
}

/// The chosen background. Colours are ARGB.
@immutable
class BackdropStyle {
  const BackdropStyle({
    this.kind = BackdropKind.theme,
    this.color1 = 0xFF1E3A5F,
    this.color2 = 0xFFB4532A,
    this.dim = defaultDim,
    this.blur = defaultBlur,
  });

  /// How much of the theme's ground is laid over a custom background
  /// (0–1). Never below [minDim], so text on the glass stays readable.
  static const double defaultDim = 0.45;
  static const double minDim = 0.2;
  static const double maxDim = 0.9;

  /// Blur radius for photos, in logical pixels.
  static const double defaultBlur = 8;
  static const double maxBlur = 30;

  final BackdropKind kind;
  final int color1;
  final int color2;
  final double dim;
  final double blur;

  bool get isCustom => kind != BackdropKind.theme;

  BackdropStyle copyWith({
    BackdropKind? kind,
    int? color1,
    int? color2,
    double? dim,
    double? blur,
  }) => BackdropStyle(
    kind: kind ?? this.kind,
    color1: color1 ?? this.color1,
    color2: color2 ?? this.color2,
    dim: (dim ?? this.dim).clamp(minDim, maxDim).toDouble(),
    blur: (blur ?? this.blur).clamp(0, maxBlur).toDouble(),
  );

  Map<String, Object> toJson() => {
    'kind': kind.name,
    'c1': color1,
    'c2': color2,
    'dim': dim,
    'blur': blur,
  };

  static BackdropStyle fromJson(Object? json) {
    if (json is! Map) return const BackdropStyle();
    final kind = BackdropKind.values
        .where((k) => k.name == json['kind'])
        .firstOrNull;
    double num0(Object? v, double fallback) =>
        v is num ? v.toDouble() : fallback;
    return const BackdropStyle().copyWith(
      kind: kind ?? BackdropKind.theme,
      color1: json['c1'] is int ? json['c1'] as int : null,
      color2: json['c2'] is int ? json['c2'] as int : null,
      dim: num0(json['dim'], defaultDim),
      blur: num0(json['blur'], defaultBlur),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is BackdropStyle &&
      other.kind == kind &&
      other.color1 == color1 &&
      other.color2 == color2 &&
      other.dim == dim &&
      other.blur == blur;

  @override
  int get hashCode => Object.hash(kind, color1, color2, dim, blur);
}

/// Keeps the chosen background. The style is a preference (so encrypted
/// backups carry it); the photo is a file in the app's own folder and is
/// not part of backups.
class BackdropStore extends ChangeNotifier {
  BackdropStore({SharedPreferences? prefs, Directory? folder})
    : _prefsOverride = prefs,
      _folderOverride = folder;

  /// The one the app uses.
  static final BackdropStore instance = BackdropStore();

  static const prefsKey = 'backdrop_style_v1';
  static const photoFileName = 'backdrop_photo.jpg';

  /// Photos are picked no larger than this on the long side.
  static const photoMaxSide = 1600.0;

  final SharedPreferences? _prefsOverride;
  final Directory? _folderOverride;
  BackdropStyle? _style;
  Uint8List? _photo;
  bool _photoLoaded = false;

  SharedPreferences get _prefs => _prefsOverride ?? PrefsManager.instance;

  /// The current style; the theme's own when nothing was chosen.
  BackdropStyle get style {
    final cached = _style;
    if (cached != null) return cached;
    // Preferences not ready yet (early start-up, some tests): the theme.
    if (_prefsOverride == null && !PrefsManager.isInitialized) {
      return const BackdropStyle();
    }
    BackdropStyle loaded;
    try {
      final raw = _prefs.getString(prefsKey);
      loaded = raw == null
          ? const BackdropStyle()
          : BackdropStyle.fromJson(jsonDecode(raw));
    } on FormatException catch (e) {
      debugPrint('Background setting unreadable, using the theme: $e');
      loaded = const BackdropStyle();
    }
    return _style = loaded;
  }

  /// The photo's bytes, once loaded; null when there is none.
  Uint8List? get photo {
    if (!_photoLoaded) {
      _photoLoaded = true;
      _loadPhoto();
    }
    return _photo;
  }

  Future<Directory?> _folder() async {
    if (_folderOverride != null) return _folderOverride;
    if (kIsWeb) return null;
    return getApplicationSupportDirectory();
  }

  Future<void> _loadPhoto() async {
    try {
      final dir = await _folder();
      if (dir == null) return;
      final file = File('${dir.path}/$photoFileName');
      if (!await file.exists()) return;
      _photo = await file.readAsBytes();
      notifyListeners();
    } on FileSystemException catch (e) {
      debugPrint('Background photo unreadable: $e');
    }
  }

  /// Saves [next] and redraws every backdrop.
  Future<void> setStyle(BackdropStyle next) async {
    _style = next;
    notifyListeners();
    await _prefs.setString(prefsKey, jsonEncode(next.toJson()));
  }

  /// Saves [bytes] as the photo and switches to it. Returns false when the
  /// photo can't be kept (no app folder, e.g. on the web).
  Future<bool> setPhoto(Uint8List bytes) async {
    final dir = await _folder();
    if (dir == null) return false;
    try {
      await dir.create(recursive: true);
      final file = File('${dir.path}/$photoFileName');
      final tmp = File('${file.path}.tmp');
      await tmp.writeAsBytes(bytes, flush: true);
      await tmp.rename(file.path);
    } on FileSystemException catch (e, st) {
      debugPrint('Could not save background photo: $e\n$st');
      return false;
    }
    _photo = bytes;
    _photoLoaded = true;
    await setStyle(style.copyWith(kind: BackdropKind.photo));
    return true;
  }

  /// Back to the theme's own background, deleting any photo.
  Future<void> reset() async {
    _photo = null;
    _photoLoaded = true;
    try {
      final dir = await _folder();
      final file = dir == null ? null : File('${dir.path}/$photoFileName');
      if (file != null && await file.exists()) await file.delete();
    } on FileSystemException catch (e) {
      debugPrint('Could not delete background photo: $e');
    }
    await setStyle(const BackdropStyle());
  }

  /// Re-reads the style, e.g. after a backup is restored.
  void reload() {
    _style = null;
    notifyListeners();
  }
}
