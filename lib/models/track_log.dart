import 'dart:math' as math;

import 'package:gpx/gpx.dart';
import 'package:latlong2/latlong.dart';

const _distance = Distance();

/// One recorded position.
class TrackPoint {
  final DateTime at;
  final double lat;
  final double lon;

  const TrackPoint({required this.at, required this.lat, required this.lon});

  LatLng get latLng => LatLng(lat, lon);

  Map<String, dynamic> toJson() => {
    't': at.toUtc().millisecondsSinceEpoch,
    'lat': lat,
    'lon': lon,
  };

  static TrackPoint? fromJson(Object? j) {
    if (j is! Map) return null;
    final t = j['t'], lat = j['lat'], lon = j['lon'];
    if (t is! int || lat is! num || lon is! num) return null;
    return TrackPoint(
      at: DateTime.fromMillisecondsSinceEpoch(t, isUtc: true),
      lat: lat.toDouble(),
      lon: lon.toDouble(),
    );
  }
}

/// One recording, from Start to Stop.
class Track {
  final String id;
  final DateTime started;
  DateTime? ended;
  final List<TrackPoint> points;

  Track({
    required this.id,
    required this.started,
    this.ended,
    List<TrackPoint>? points,
  }) : points = points ?? [];

  /// Total length along the points, in kilometres.
  double get distanceKm {
    var km = 0.0;
    for (var i = 1; i < points.length; i++) {
      km += _distance.as(
        LengthUnit.Meter,
        points[i - 1].latLng,
        points[i].latLng,
      );
    }
    return km / 1000;
  }

  Duration duration(DateTime now) => (ended ?? now).difference(started);

  Map<String, dynamic> toJson() => {
    'id': id,
    'started': started.toUtc().millisecondsSinceEpoch,
    if (ended != null) 'ended': ended!.toUtc().millisecondsSinceEpoch,
    'points': [for (final p in points) p.toJson()],
  };

  static Track? fromJson(Object? j) {
    if (j is! Map) return null;
    final id = j['id'], started = j['started'], ended = j['ended'];
    if (id is! String || started is! int) return null;
    return Track(
      id: id,
      started: DateTime.fromMillisecondsSinceEpoch(started, isUtc: true),
      ended: ended is int
          ? DateTime.fromMillisecondsSinceEpoch(ended, isUtc: true)
          : null,
      points: [
        for (final p in (j['points'] as List? ?? const []))
          ?TrackPoint.fromJson(p),
      ],
    );
  }
}

/// Keeps a log sparse: a new point only after moving [minMoveMeters], or
/// after [stillInterval] without moving (so long stops still show up).
class TrackRecorder {
  const TrackRecorder({
    this.minMoveMeters = 25,
    this.stillInterval = const Duration(minutes: 15),
  });

  final double minMoveMeters;
  final Duration stillInterval;

  bool shouldRecord(TrackPoint? last, TrackPoint next) {
    if (last == null) return true;
    final moved = _distance.as(LengthUnit.Meter, last.latLng, next.latLng);
    return moved >= minMoveMeters ||
        next.at.difference(last.at) >= stillInterval;
  }
}

/// Rounds a position to the middle of a grid square about [meters] wide,
/// so a shared track doesn't reveal an exact spot.
LatLng snapToGridCenter(double lat, double lon, double meters) {
  const metersPerDegLat = 111320.0;
  final latStep = meters / metersPerDegLat;
  final snappedLat = (lat / latStep).floorToDouble() * latStep + latStep / 2;
  final metersPerDegLon =
      metersPerDegLat * math.cos(snappedLat * math.pi / 180).abs();
  final lonStep = meters / math.max(metersPerDegLon, 1);
  final snappedLon = (lon / lonStep).floorToDouble() * lonStep + lonStep / 2;
  return LatLng(snappedLat, snappedLon);
}

/// The track as a GPX 1.1 document with one track segment.
String trackToGpx(Track track, {required String name}) {
  final gpx = Gpx()
    ..version = '1.1'
    ..creator = 'NOTORYX Core'
    ..metadata = Metadata(name: name, time: track.started.toUtc())
    ..trks = [
      Trk(
        name: name,
        trksegs: [
          Trkseg(
            trkpts: [
              for (final p in track.points)
                Wpt(lat: p.lat, lon: p.lon, time: p.at.toUtc()),
            ],
          ),
        ],
      ),
    ];
  return GpxWriter().asString(gpx, pretty: true);
}
