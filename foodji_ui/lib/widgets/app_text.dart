import 'package:flutter/material.dart';
import 'package:foodji_ui/misc/colors.dart';

enum AppTextSize { verySmall, small, normal, subtitle, title }

enum AppFontFamily { bauhaus, forte }

class AppText extends StatelessWidget {
  final AppTextSize size;
  final String text;
  final Color color;
  final AppFontFamily fontFamily;
  final Color backgroundColor;
  final FontStyle fontStyle;

  const AppText(
      {Key? key,
      this.size = AppTextSize.normal,
      required this.text,
      this.color = AppColors.textColor,
      this.fontFamily = AppFontFamily.bauhaus,
      this.backgroundColor = AppColors.none,
      this.fontStyle = FontStyle.normal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double resolvedSize;
    switch (size) {
      case AppTextSize.verySmall:
        resolvedSize = 12;
        break;
      case AppTextSize.small:
        resolvedSize = 14;
        break;
      case AppTextSize.normal:
        resolvedSize = 16;
        break;
      case AppTextSize.subtitle:
        resolvedSize = 22;
        break;
      case AppTextSize.title:
        resolvedSize = 28;
        break;
      default:
        resolvedSize = 16;
        break;
    }
    String resolvedFontFamily;
    switch (fontFamily) {
      case AppFontFamily.bauhaus:
        resolvedFontFamily = 'bauhaus';
        break;
      case AppFontFamily.forte:
        resolvedFontFamily = 'forte';
        break;
      default:
        resolvedFontFamily = 'bauhaus';
        break;
    }
    return backgroundColor == AppColors.none
        ? Text(
            text,
            style: TextStyle(
                color: color,
                fontSize: resolvedSize,
                fontFamily: resolvedFontFamily,
                fontStyle: fontStyle),
          )
        : Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(50)),
            child: Text(
              text,
              style: TextStyle(
                  color: color,
                  fontSize: resolvedSize,
                  fontFamily: resolvedFontFamily),
            ),
          );
  }
}
