import 'package:flutter/material.dart';

class AppUtil {
  static RoundedRectangleBorder get fullTile => const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15), bottomRight: Radius.circular(15)));

  static RoundedRectangleBorder get firstTile => const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(15)));

  static RoundedRectangleBorder get lastTile => const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(15)));
}
