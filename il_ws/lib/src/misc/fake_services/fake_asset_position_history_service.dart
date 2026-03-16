import 'dart:convert';

import 'package:il_core/il_entities.dart';
import 'package:il_ws/src/services/asset_position_history_service.dart';

import 'package:flutter/services.dart' as root_bundle;

class FakeAssetPositionHistoryService implements IAssetPositionHistoryService {
  @override
  Future<List<AssetPositionHistory>> getPositionHistory(
      {required int assetId, required int floorMapId, required DateTime startDate, required DateTime endDate}) {
    return Future.delayed(Duration(milliseconds: 200), () {
      if (floorMapId != 1) return [];
      return _loadPositionHistory(assetId, floorMapId, startDate, endDate, 'assets/fake/location_history_1.txt');
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

  static Future<List<AssetPositionHistory>> _loadPositionHistory(
      int assetId, int floorMapId, DateTime startDate, DateTime endDate, String key) async {
    var ls = LineSplitter();

    var data = await root_bundle.rootBundle.loadString(key);
    var lines = ls.convert(data).map((e) => e.trim()).where((e) => e.isNotEmpty);

    int id = 1;
    DateTime time = startDate;
    var dtime = Duration(minutes: 1);

    List<AssetPositionHistory> result = lines.map((line) {
      var parts = line.split(',');
      double x = double.parse(parts[0].trim());
      double y = double.parse(parts[1].trim());

      var p = AssetPositionHistory(id: id, assetId: assetId, x: x, y: y, timestamp: time, floorMapId: floorMapId);

      id++;
      time = time.add(dtime);

      return p;
    }).toList();

    return result;
  }
}
