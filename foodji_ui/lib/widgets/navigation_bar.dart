import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:foodji_ui/misc/colors.dart';
import 'package:foodji_ui/pages/exploration_page.dart';
import 'package:foodji_ui/pages/ingredients_page.dart';
import 'package:foodji_ui/pages/profile_page.dart';
import 'package:foodji_ui/pages/recipes_page.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../pages/converter_page.dart';
import '../pages/favorites_page.dart';
import '../pages/grocery_page.dart';
import '../pages/pantry_page.dart';
import 'custom_fab_location.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({super.key});

  @override
  State<NavigationBar> createState() => NavigationBarState();
}

class NavigationBarState extends State<NavigationBar> {
  List pages = [
    const RecipesPage(),
    const FavoritesPage(),
    const ExplorationPage(),
    const ProfilePage(),
    const ConverterPage(),
    const IngredientsPage(),
    const PantryPage(),
    const GroceryPage()
  ];
  int currentMenu = 0;
  int currentPage = 0;
  void onMenuTap(int menuIndex) {
    setState(() {
      currentMenu = menuIndex;
      currentPage = menuIndex;
    });
  }

  void onSpeedDialTap(int speedDialIndex) {
    setState(() {
      currentMenu = 4;
      currentPage = currentMenu + speedDialIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: pages[currentPage],
        bottomNavigationBar: BottomAppBar(
            color: AppColors.backgroundColor,
            elevation: 0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: IconButton(
                          icon: const Icon(Icons.maps_home_work),
                          color: currentPage == 0
                              ? AppColors.highlightColor3
                              : AppColors.textColor,
                          onPressed: () => onMenuTap(0))),
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: IconButton(
                          icon: const Icon(Icons.star_border_outlined),
                          color: currentPage == 1
                              ? AppColors.highlightColor3
                              : AppColors.textColor,
                          onPressed: () => onMenuTap(1))),
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: IconButton(
                          icon: const Icon(Icons.language),
                          color: currentPage == 2
                              ? AppColors.highlightColor3
                              : AppColors.textColor,
                          onPressed: () => onMenuTap(2))),
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: IconButton(
                          icon: const Icon(Icons.person_outline),
                          color: currentPage == 3
                              ? AppColors.highlightColor3
                              : AppColors.textColor,
                          onPressed: () => onMenuTap(3))),
                  const Padding(
                      padding: EdgeInsets.all(5.0), child: SizedBox(width: 40))
                ])),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: SpeedDial(
          icon: Icons.settings,
          activeIcon: Icons.settings,
          backgroundColor: AppColors.backgroundColor,
          foregroundColor: currentPage >= 4
              ? AppColors.highlightColor3
              : AppColors.textColor,
          activeBackgroundColor: AppColors.backgroundColor,
          activeForegroundColor: AppColors.highlightColor3,
          buttonSize: 50.0,
          visible: true,
          closeManually: false,
          marginEnd: (MediaQuery.of(context).size.width - 240) / 6,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          elevation: 0,
          children: [
            SpeedDialChild(
                child: const Icon(Icons.flip_camera_android),
                backgroundColor: AppColors.backgroundColor,
                foregroundColor: currentPage == 4
                    ? AppColors.highlightColor3
                    : AppColors.textColor,
                label: AppLocalizations.of(context)!.menu_converter,
                labelStyle: TextStyle(
                    fontSize: 12.0,
                    color: currentPage == 4
                        ? AppColors.highlightColor3
                        : AppColors.textColor),
                onTap: () => onSpeedDialTap(0)),
            SpeedDialChild(
                child: const Icon(Icons.menu_book_outlined),
                backgroundColor: AppColors.backgroundColor,
                foregroundColor: currentPage == 5
                    ? AppColors.highlightColor3
                    : AppColors.textColor,
                label: AppLocalizations.of(context)!.menu_ingredients,
                labelStyle: TextStyle(
                    fontSize: 12.0,
                    color: currentPage == 5
                        ? AppColors.highlightColor3
                        : AppColors.textColor),
                onTap: () => onSpeedDialTap(1)),
            SpeedDialChild(
                child: const Icon(Icons.kitchen_outlined),
                backgroundColor: AppColors.backgroundColor,
                foregroundColor: currentPage == 6
                    ? AppColors.highlightColor3
                    : AppColors.textColor,
                label: AppLocalizations.of(context)!.menu_pantry,
                labelStyle: TextStyle(
                    fontSize: 12.0,
                    color: currentPage == 6
                        ? AppColors.highlightColor3
                        : AppColors.textColor),
                onTap: () => onSpeedDialTap(2)),
            SpeedDialChild(
                child: const Icon(Icons.local_grocery_store_outlined),
                backgroundColor: AppColors.backgroundColor,
                foregroundColor: currentPage == 7
                    ? AppColors.highlightColor3
                    : AppColors.textColor,
                label: AppLocalizations.of(context)!.menu_grocery,
                labelStyle: TextStyle(
                    fontSize: 12.0,
                    color: currentPage == 7
                        ? AppColors.highlightColor3
                        : AppColors.textColor),
                onTap: () => onSpeedDialTap(3))
          ],
        ));
  }
}
