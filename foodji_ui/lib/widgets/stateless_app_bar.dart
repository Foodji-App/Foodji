import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart' as material;

import '../misc/colors.dart';
import 'app_text.dart';

class AppBar extends StatelessWidget with PreferredSizeWidget {
  AppBar(this.title, {super.key});
  final String title;
  @override
  Size get preferredSize => const Size.fromHeight(40);
  @override
  Widget build(BuildContext context) {
    return material.AppBar(
        centerTitle: false,
        backgroundColor: AppColors.textColor,
        leadingWidth: MediaQuery.of(context).size.width / 2.5,
        leading: Container(
            margin:
                const EdgeInsets.only(top: 8, bottom: 8, left: 14, right: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("img/logo.png"), fit: BoxFit.contain),
            )),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 14),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                        text: title,
                        color: AppColors.backgroundColor,
                        size: AppTextSize.normal,
                        fontFamily: AppFontFamily.bauhaus)
                  ]))
        ]);
  }
}
