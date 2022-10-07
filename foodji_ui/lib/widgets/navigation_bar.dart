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
        bottomNavigationBar: BottomNavigationBar(
            unselectedFontSize: 12,
            selectedFontSize: 16,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.backgroundColor,
            onTap: onMenuTap,
            currentIndex: currentMenu,
            selectedItemColor: AppColors.highlightColor3,
            unselectedItemColor: AppColors.textColor,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                  label: AppLocalizations.of(context)!.menu_recipes,
                  icon: const Icon(Icons.maps_home_work)),
              BottomNavigationBarItem(
                  label: AppLocalizations.of(context)!.menu_favourites,
                  icon: const Icon(Icons.star_border_outlined)),
              BottomNavigationBarItem(
                  label: AppLocalizations.of(context)!.menu_exploration,
                  icon: const Icon(Icons.language)),
              BottomNavigationBarItem(
                  label: AppLocalizations.of(context)!.menu_profile,
                  icon: const Icon(Icons.person_outline)),
              BottomNavigationBarItem(
                  label: AppLocalizations.of(context)!.menu_tools,
                  icon: const Icon(Icons.settings))
            ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: SpeedDial(
          icon: Icons.settings,
          activeIcon: Icons.settings,
          backgroundColor: AppColors.backgroundColor,
          foregroundColor: AppColors.highlightColor3,
          activeBackgroundColor: AppColors.backgroundColor,
          activeForegroundColor: AppColors.highlightColor3,
          buttonSize: 60.0,
          visible: true,
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          elevation: 0,
          children: [
            SpeedDialChild(
                child: const Icon(Icons.flip_camera_android),
                backgroundColor: AppColors.backgroundColor,
                foregroundColor: AppColors.textColor,
                label: AppLocalizations.of(context)!.menu_converter,
                labelStyle: const TextStyle(fontSize: 12.0),
                onTap: () => onSpeedDialTap(0)),
            SpeedDialChild(
                child: const Icon(Icons.menu_book_outlined),
                backgroundColor: AppColors.backgroundColor,
                foregroundColor: AppColors.textColor,
                label: AppLocalizations.of(context)!.menu_ingredients,
                labelStyle: const TextStyle(fontSize: 12.0),
                onTap: () => onSpeedDialTap(1)),
            SpeedDialChild(
                child: const Icon(Icons.kitchen_outlined),
                backgroundColor: AppColors.backgroundColor,
                foregroundColor: AppColors.textColor,
                label: AppLocalizations.of(context)!.menu_pantry,
                labelStyle: const TextStyle(fontSize: 12.0),
                onTap: () => onSpeedDialTap(2)),
            SpeedDialChild(
                child: const Icon(Icons.local_grocery_store_outlined),
                backgroundColor: AppColors.backgroundColor,
                foregroundColor: AppColors.textColor,
                label: AppLocalizations.of(context)!.menu_grocery,
                labelStyle: const TextStyle(fontSize: 12.0),
                onTap: () => onSpeedDialTap(3))
          ],
        ));
  }
}
