import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:foodji_ui/misc/colors.dart';

class AppBar extends StatelessWidget with PreferredSizeWidget {
  const AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return material.AppBar(
        backgroundColor: AppColors.textColor,
        leadingWidth: MediaQuery.of(context).size.width / 3,
        leading: Container(
            margin: const EdgeInsets.only(left: 14),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("img/logo.png"), fit: BoxFit.fitWidth),
            )));
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}
