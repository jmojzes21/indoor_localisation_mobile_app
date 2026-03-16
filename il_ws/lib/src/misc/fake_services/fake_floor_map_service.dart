import 'dart:typed_data';
import 'dart:ui';

import 'package:il_core/il_entities.dart';
import 'package:il_ws/il_ws.dart';

import 'package:flutter/services.dart' as root_bundle;

class FakeFloorMapService implements IFloorMapService {
  List<FloorMap> get _facilities => [
        FloorMap(
          id: 1,
          name: 'Facility A1',
          trackingArea: Rect.fromLTWH(0, 0, 3000, 2000),
          size: Size(3000, 2000),
          image: null,
          imageType: 'svg',
        ),
        FloorMap(
          id: 2,
          name: 'Facility B2',
          trackingArea: Rect.fromLTWH(0, 0, 3000, 2000),
          size: Size(3000, 2000),
          image: null,
          imageType: 'svg',
        ),
      ];

  Map<int, List<FloorMapZone>> get _zones => <int, List<FloorMapZone>>{
        1: [
          FloorMapZone(
            id: 11,
            name: 'Zone 1',
            colorValue: 0xFFC90E,
            points: _getRectPoints(182.01, 152.57, 958.22, 1632.71),
            floorMapId: 1,
          ),
          FloorMapZone(
            id: 12,
            name: 'Zone 2',
            colorValue: 0x00A2E8,
            points: _getRectPoints(1384.06, 177.19, 1367.1, 1036.64),
            floorMapId: 1,
          ),
        ],
        2: [
          FloorMapZone(
            id: 21,
            name: 'Zone 1',
            colorValue: 0x22B14C,
            points: _getRectPoints(798.70, 1188.57, 1934.27, 613.21),
            floorMapId: 2,
          ),
        ],
      };

  @override
  Future<List<FloorMap>> getAllFloorMaps() async {
    Uint8List f1 = await _loadFloorMap('assets/fake/floor_map_1.svg');
    Uint8List f2 = await _loadFloorMap('assets/fake/floor_map_2.svg');

    var facilities = _facilities;
    facilities.firstWhere((e) => e.id == 1).image = f1;
    facilities.firstWhere((e) => e.id == 2).image = f2;

    return Future.delayed(Duration(milliseconds: 500), () {
      return facilities;
    });
  }

  @override
  Future<List<FloorMapZone>> getFloorMapZones(int floorMapId) async {
    return _zones[floorMapId]!;
  }

  @override
  Future<void> clearCachedFloorMaps() async {}

  static List<Offset> _getRectPoints(double x, double y, double w, double h) {
    return [
      Offset(x, y),
      Offset(x + w, y),
      Offset(x + w, y + h),
      Offset(x, y + h),
    ];
  }

  static Future<Uint8List> _loadFloorMap(String key) async {
    return (await root_bundle.rootBundle.load(key)).buffer.asUint8List();
  }
}
