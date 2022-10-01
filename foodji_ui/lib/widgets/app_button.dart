import 'package:flutter/material.dart';
import 'package:foodji_ui/misc/colors.dart';

import 'app_text.dart';

// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  String? text;
  IconData? icon;
  bool? isIcon;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  double size;

  AppButton({
    Key? key,
    this.text = 'btn',
    this.icon,
    this.isIcon = false,
    this.textColor = Colors.black54,
    this.backgroundColor = Colors.white54,
    this.borderColor = AppColors.none,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor,
          border: Border.all(
              color:
                  borderColor == AppColors.none ? backgroundColor : borderColor,
              width: 1),
        ),
        child: isIcon == false && icon != null
            ? Center(child: AppText(text: text!, color: textColor))
            : Center(child: Icon(icon, color: textColor)));
  }
}
