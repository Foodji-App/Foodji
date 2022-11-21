import 'package:flutter/material.dart';
import 'package:foodji_ui/models/unit_type_volume_map.dart';
import 'package:foodji_ui/models/unit_type_weight_map.dart';

class AppUtil {
  static RoundedRectangleBorder get fullTile => const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15), bottomRight: Radius.circular(15)));

  RoundedRectangleBorder get firstTile => const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(15)));

  RoundedRectangleBorder get lastTile => const RoundedRectangleBorder(
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
}
