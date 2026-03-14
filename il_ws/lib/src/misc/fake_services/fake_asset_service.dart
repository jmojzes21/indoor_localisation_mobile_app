import 'package:il_core/il_entities.dart';
import 'package:il_ws/il_fake_services.dart';
import 'package:il_ws/il_ws.dart';

class FakeAssetService implements IAssetService {
  @override
  Future<List<Asset>> getAllAssets() async {
    return Future.delayed(Duration(milliseconds: 200), () async {
      var assets = <Asset>[];

      var floorMapService = FakeFloorMapService();
      var floorMaps = await floorMapService.getAllFloorMaps();

      for (var floorMap in floorMaps) {
        assets.addAll(getAssets(floorMap.id));
      }

      return assets;
    });
  }

  @override
  Future<List<Asset>> getAssetsByFloorMap(int floorMapId) async {
    return Future.delayed(Duration(milliseconds: 200), () {
      return getAssets(floorMapId);
    });
  }

  List<Asset> getAssets(int floorMapId) {
    int n = floorMapId * 10;
    return [
      Asset(id: n, name: 'Asset A1', x: 100, y: 100, lastSync: DateTime.now(), active: true, floorMapId: floorMapId),
      Asset(
          id: n + 1, name: 'Asset B2', x: 200, y: 200, lastSync: DateTime.now(), active: true, floorMapId: floorMapId),
      Asset(
          id: n + 2, name: 'Asset C3', x: 300, y: 300, lastSync: DateTime.now(), active: true, floorMapId: floorMapId),
      Asset(
          id: n + 3, name: 'Asset D4', x: 400, y: 400, lastSync: DateTime.now(), active: true, floorMapId: floorMapId),
    ];
  }

  @override
  void assignFloorMaps(List<Asset> assets, List<FloorMap> floorMaps) {
    for (var asset in assets) {
      var floorMap = floorMaps.firstWhere((e) => e.id == asset.floorMapId);
      asset.floorMap = floorMap;
    }
  }
}
