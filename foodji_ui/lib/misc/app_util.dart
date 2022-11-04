import 'package:flutter/material.dart';

class AppUtil {

  RoundedRectangleBorder get fullTile => const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15), bottomRight: Radius.circular(15)));

  RoundedRectangleBorder get firstTile => const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(15)));

  RoundedRectangleBorder get lastTile => const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(15)));
}
