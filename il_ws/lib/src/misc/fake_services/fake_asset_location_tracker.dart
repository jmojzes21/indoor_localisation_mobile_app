import 'dart:async';
import 'dart:math' as math;
import 'package:il_core/il_entities.dart';
import 'package:il_ws/il_fake_services.dart';
import 'package:il_ws/il_ws.dart';

class _Asset {
  int assetId = 0;
  int floorMapId = 0;

  double sx = 0;
  double sy = 0;

  double x = 0;
  double y = 0;

  double tx = 0;
  double ty = 0;

  double t = 0;
  double dt = 0;
  double speed = 0;

  int floorMapWidth = 3000;
  int floorMapHeight = 2000;

  _Asset(Asset a) {
    assetId = a.id;
    floorMapId = a.floorMapId;
    x = a.x;
    y = a.y;
  }

  void randomSpeed(math.Random r) {
    speed = r.nextInt(30) + 20;
  }

  void randomTarget(math.Random r) {
    sx = x;
    sy = y;

    tx = r.nextInt(floorMapWidth).toDouble();
    ty = r.nextInt(floorMapHeight).toDouble();

    t = 0;

    double dx = tx - sx;
    double dy = ty - sy;
    double l = math.sqrt(dx * dx + dy * dy);

    dt = speed / l;
  }

  void move(math.Random r) {
    x = sx * (1.0 - t) + tx * t;
    y = sy * (1.0 - t) + ty * t;

    t += dt;

    if (t >= 1) {
      randomTarget(r);
    }
  }

  AssetLocation getLocation() {
    return AssetLocation(id: assetId, x: x, y: y, floorMapId: floorMapId);
  }
}

class FakeAssetLocationTracker implements IAssetLocationTracker {
  Timer? _timer;
  StreamController<AssetLocation>? _streamController;
  bool _active = false;

  List<_Asset> _assets = [];
  final _random = math.Random();

  @override
  Future<void> connect() async {
    if (_active) {
      close();
    }

    var assetService = FakeAssetService();
    _assets = [...assetService.getAssets(1), ...assetService.getAssets(2)].map((e) => _Asset(e)).toList();

    for (var e in _assets) {
      e.randomSpeed(_random);
      e.randomTarget(_random);
    }

    _streamController = StreamController();

    _timer = Timer.periodic(
      Duration(milliseconds: 200),
      (_) {
        for (var asset in _assets) {
          asset.move(_random);
          _streamController!.sink.add(asset.getLocation());
        }
      },
    );

    _active = true;
    return Future.delayed(Duration(milliseconds: 200));
  }

  @override
  void close() {
    _streamController?.close();
    _streamController = null;

    _timer?.cancel();
    _timer = null;
    _active = false;
  }

  @override
  Stream<AssetLocation> get stream => _streamController!.stream;
}
