import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodji_ui/misc/colors.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubit/app_globals.dart' as globals;
import '../cubit/app_cubit_states.dart';
import '../cubit/app_cubits.dart';
import '../cubit/app_globals.dart';
import 'app_text.dart';

class AppBar extends StatefulWidget with PreferredSizeWidget {
  const AppBar({Key? key}) : super(key: key);

  @override
  AppBarState createState() => AppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(40);
}

class AppBarState extends State<AppBar> {
  String getTitle(context, page) {
    switch (page) {
      case 0:
        return AppLocalizations.of(context)!.menu_recipes;
      case 1:
        return AppLocalizations.of(context)!.menu_favourites;
      case 2:
        return AppLocalizations.of(context)!.menu_exploration;
      case 3:
        return AppLocalizations.of(context)!.menu_profile;
      case 4:
        return AppLocalizations.of(context)!.menu_converter;
      case 5:
        return AppLocalizations.of(context)!.menu_ingredients;
      case 6:
        return AppLocalizations.of(context)!.menu_pantry;
      case 7:
        return AppLocalizations.of(context)!.menu_grocery;
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    int page = -1;
    // Observer
    runOnceAndRunForEveryChange(() {
      if (mounted) {
        page = globals.getActivePage();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {});
        });
      }
    });
    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
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
          title: AppText(
              text: getTitle(context, page),
              color: AppColors.backgroundColor,
              size: AppTextSize.normal,
              fontFamily: AppFontFamily.bauhaus));
    });
  }
}
