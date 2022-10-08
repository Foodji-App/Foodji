import 'package:flutter/material.dart';

class CustomFABLocation implements FloatingActionButtonLocation {
  final double x;
  final double y;
  CustomFABLocation(this.x, this.y);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    return Offset(x, y);
  }
}
