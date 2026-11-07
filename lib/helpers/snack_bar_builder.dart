import 'package:flutter/material.dart';

// showDismissibleSnackBar shows  a [SnackBar] with tap to dismiss
// all other properties are default and optional
void showDismissibleSnackBar(
  BuildContext context, {
  Key? key,
  required Widget content,
  Color? backgroundColor,
  double? elevation,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
  double? width,
  ShapeBorder? shape,
  HitTestBehavior? hitTestBehavior,
  SnackBarBehavior? behavior,
  SnackBarAction? action,
  double? actionOverflowThreshold,
  bool? showCloseIcon,
  Color? closeIconColor,
  Duration? duration,
  bool? persist,
  Animation<double>? animation,
  void Function()? onVisible,
  DismissDirection? dismissDirection,
  Clip? clipBehavior,
}) {
  // Callers often reach here after an async gap; the context may already be
  // unmounted, or deactivated (popped but not yet disposed) — ancestor
  // lookups on a deactivated element throw. Showing nothing is the right
  // outcome in both cases.
  if (!context.mounted) return;
  var isActive = true;
  assert(() {
    isActive = (context as Element).debugIsActive;
    return true;
  }());
  if (!isActive) return;
  final messenger = ScaffoldMessenger.maybeOf(context);
  if (messenger == null) return;
  messenger.showSnackBar(
    SnackBar(
      key: key,
      content: GestureDetector(
        onTap: () => messenger.hideCurrentSnackBar(),
        child: content,
      ),
      backgroundColor: backgroundColor,
      elevation: elevation,
      margin: margin,
      padding: padding,
      width: width,
      shape: shape,
      hitTestBehavior: hitTestBehavior,
      behavior: behavior,
      action: action,
      actionOverflowThreshold: actionOverflowThreshold,
      showCloseIcon: showCloseIcon,
      closeIconColor: closeIconColor,
      duration: duration ?? const Duration(seconds: 4),
      // Flutter defaults action SnackBars to persistent; keep Undo actionable
      // while ensuring transient confirmations disappear automatically.
      persist: persist ?? false,
      animation: animation,
      onVisible: onVisible,
      dismissDirection: dismissDirection ?? DismissDirection.down,
      clipBehavior: clipBehavior ?? Clip.hardEdge,
    ),
  );
}

/// The app's standard [SnackBar] for callers that captured a
/// [ScaffoldMessengerState] before an async gap: tap to dismiss, 4 s, and
/// never persistent (Flutter keeps action snack bars up indefinitely).
SnackBar meshSnackBar({
  required Widget content,
  SnackBarAction? action,
  Duration? duration,
}) {
  return SnackBar(
    content: Builder(
      builder: (context) => GestureDetector(
        onTap: () => ScaffoldMessenger.maybeOf(context)?.hideCurrentSnackBar(),
        child: content,
      ),
    ),
    action: action,
    duration: duration ?? const Duration(seconds: 4),
    persist: false,
    dismissDirection: DismissDirection.down,
  );
}

/// Turns a caught error into text fit for a person: drops Dart's
/// `Exception: ` / `Bad state: ` style prefixes and platform-channel noise.
String friendlyError(Object error) {
  var text = error.toString();
  final platform = RegExp(r'^PlatformException\([^,]*, ([^,]*),')
      .firstMatch(text);
  if (platform != null) text = platform.group(1)!;
  text = text.replaceFirst(
    RegExp(
      r'^(Exception|Bad state|Invalid argument\(s\)|FormatException|'
      r'TimeoutException|StateError|SocketException|FileSystemException)'
      r'(\s*after [^:]*)?:\s*',
    ),
    '',
  );
  return text.trim().isEmpty ? error.runtimeType.toString() : text.trim();
}
