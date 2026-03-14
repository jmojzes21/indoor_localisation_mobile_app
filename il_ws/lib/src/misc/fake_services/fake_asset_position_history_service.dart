import 'package:il_core/il_entities.dart';
import 'package:il_ws/src/services/asset_position_history_service.dart';

class FakeAssetPositionHistoryService implements IAssetPositionHistoryService {
  @override
  Future<List<AssetPositionHistory>> getPositionHistory(
      {required int assetId, required int floorMapId, required DateTime startDate, required DateTime endDate}) {
    return Future.delayed(Duration(milliseconds: 200), () {
      return [];
    });
  }

  @override
  Future<List<AssetZoneHistory>> getZoneHistory({
    required int assetId,
    required int floorMapId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return Future.delayed(Duration(milliseconds: 200), () {
      if (assetId != 10) return [];

      return [
        AssetZoneHistory(
          id: 1,
          assetId: 10,
          zoneId: 11,
          enterDateTime: DateTime.parse('2024-12-10 08:00'),
          exitDateTime: DateTime.parse('2024-12-10 09:00'),
        ),
        AssetZoneHistory(
          id: 2,
          assetId: 10,
          zoneId: 11,
          enterDateTime: DateTime.parse('2024-12-10 10:00'),
          exitDateTime: DateTime.parse('2024-12-10 11:30'),
        ),
        AssetZoneHistory(
          id: 3,
          assetId: 10,
          zoneId: 12,
          enterDateTime: DateTime.parse('2024-12-10 11:40'),
          exitDateTime: DateTime.parse('2024-12-10 14:00'),
        ),
        AssetZoneHistory(
          id: 4,
          assetId: 10,
          zoneId: 11,
          enterDateTime: DateTime.parse('2024-12-10 14:10'),
          exitDateTime: DateTime.parse('2024-12-10 14:20'),
        ),
      ];
    });
  }
}
