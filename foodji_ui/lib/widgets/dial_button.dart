import 'package:flutter/material.dart';
import 'package:foodji_ui/misc/colors.dart';

// ignore: must_be_immutable
class DialButton extends StatelessWidget {
  IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  Function()? onPressed;

  DialButton(
      {Key? key,
      required this.icon,
      this.iconColor = AppColors.textColor,
      this.backgroundColor = AppColors.backgroundColor,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      child: IconButton(
        icon: Icon(icon),
        color: iconColor,
        onPressed: () {
          onPressed!();
        },
      ),
    );
  }
}
