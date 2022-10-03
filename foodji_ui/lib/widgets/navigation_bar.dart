import 'package:flutter/material.dart';
import 'package:foodji_ui/misc/colors.dart';
import 'package:foodji_ui/pages/exploration_page.dart';
import 'package:foodji_ui/pages/profile_page.dart';
import 'package:foodji_ui/pages/recipes_page.dart';
import 'package:foodji_ui/pages/tools_page.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../pages/favorites_page.dart';

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
    const ToolsPage()
  ];
  int currentMenu = 0;
  void onTap(int menuIndex) {
    setState(() {
      currentMenu = menuIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: pages[currentMenu],
      bottomNavigationBar: BottomNavigationBar(
          unselectedFontSize: 12,
          selectedFontSize: 16,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.backgroundColor,
          onTap: onTap,
          currentIndex: currentMenu,
          selectedItemColor: AppColors.highlightColor3,
          unselectedItemColor: AppColors.textColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
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
    );
  }
}
