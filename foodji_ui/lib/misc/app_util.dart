import 'package:flutter/material.dart';
import 'package:foodji_ui/models/unit_type_volume_map.dart';
import 'package:foodji_ui/models/unit_type_weight_map.dart';

class AppUtil {
  static RoundedRectangleBorder get fullTile => const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15), bottomRight: Radius.circular(15)));

  static RoundedRectangleBorder get firstTile => const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(15)));

  static RoundedRectangleBorder get lastTile => const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(15)));

  num unitConvert(
      num baseValue, String originUnitType, String destinationUnitType) {
    if ((unitTypeVolume.containsKey(originUnitType) &&
            !unitTypeVolume.containsKey(destinationUnitType)) ||
        (unitTypeWeight.containsKey(originUnitType) &&
            !unitTypeWeight.containsKey(destinationUnitType))) {
      return 0;
    } else {
      if (unitTypeVolume.containsKey(originUnitType)) {
        return baseValue *
            unitTypeVolume.entries
                .firstWhere((element) => element.key == destinationUnitType)
                .value /
            unitTypeVolume.entries
                .firstWhere((element) => element.key == originUnitType)
                .value;
      } else if (unitTypeWeight.containsKey(originUnitType)) {
        return baseValue *
            unitTypeWeight.entries
                .firstWhere((element) => element.key == destinationUnitType)
                .value /
            unitTypeWeight.entries
                .firstWhere((element) => element.key == originUnitType)
                .value;
      }
      return 0;
    }
  }

  //static array of one to one hundred. Supposed to fix the unique key issue
  static List<int> get keyDirtyFix => [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100];
}
