import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:foodji_ui/misc/colors.dart';
import 'package:foodji_ui/pages/exploration_page.dart';
import 'package:foodji_ui/pages/ingredients_page.dart';
import 'package:foodji_ui/pages/profile_page.dart';
import 'package:foodji_ui/pages/converter_page.dart';
import 'package:foodji_ui/pages/grocery_page.dart';
import 'package:foodji_ui/pages/pantry_page.dart';
import 'package:foodji_ui/pages/recipes_page.dart';
import '../widgets/app_bar.dart' as app_bar_widget;
import '../cubit/app_globals.dart' as globals;

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({super.key});

  @override
  State<NavigationBar> createState() => NavigationBarState();
}

class NavigationBarState extends State<NavigationBar> {
  List pages = [
    const RecipesPage(),
    const ExplorationPage(),
    const ProfilePage(),
    const ConverterPage(),
    const IngredientsPage(),
    const PantryPage(),
    const GroceryPage()
  ];
  int currentMenu = 0;
  int currentPage = 0;
  int lastSelectedSpeedDial = -1;
  void onMenuTap(int menuIndex) {
    setState(() {
      currentMenu = menuIndex;
      currentPage = menuIndex;
    });
  }

  void onSpeedDialTap(int speedDialIndex) {
    if (speedDialIndex == 0) globals.setActivePage(2);
    setState(() {
      currentMenu = 2;
      currentPage = currentMenu + speedDialIndex;
      lastSelectedSpeedDial = speedDialIndex;
    });
  }

  IconData getFABPassiveIcon() {
    switch (lastSelectedSpeedDial) {
      case 0:
        return Icons.manage_accounts_outlined;
      case 1:
        return Icons.flip_camera_android_outlined;
      case 2:
        return Icons.egg_outlined;
      case 3:
        return Icons.kitchen_outlined;
      case 4:
        return Icons.local_grocery_store_outlined;
      default:
        return Icons.build_circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isDialOpen = ValueNotifier(false);
    return SafeArea(
        child: Scaffold(
            appBar: const app_bar_widget.AppBar(),
            backgroundColor: AppColors.backgroundColor,
            body: pages[currentPage],
            bottomNavigationBar: BottomAppBar(
                color: AppColors.backgroundColor,
                elevation: 0,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(1),
                          child: IconButton(
                              icon: currentPage == 0
                                  ? const Icon(Icons.menu_book)
                                  : const Icon(Icons.book),
                              color: currentPage == 0
                                  ? AppColors.highlightColor3
                                  : AppColors.textColor,
                              onPressed: () => onMenuTap(0))),
                      Padding(
                          padding: const EdgeInsets.all(1),
                          child: IconButton(
                              icon: currentPage == 1
                                  ? const Icon(Icons.travel_explore_outlined)
                                  : const Icon(Icons.public),
                              color: currentPage == 1
                                  ? AppColors.highlightColor3
                                  : AppColors.textColor,
                              onPressed: () => onMenuTap(1))),
                      const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: SizedBox(width: 20))
                    ])),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            floatingActionButton: Padding(
                padding: EdgeInsets.only(
                    top: 42,
                    right: (MediaQuery.of(context).size.width - 240) / 6),
                child: SpeedDial(
                  icon: getFABPassiveIcon(),
                  activeIcon: Icons.build_outlined,
                  backgroundColor: AppColors.backgroundColor,
                  foregroundColor: currentPage >= 2
                      ? AppColors.highlightColor3
                      : AppColors.textColor,
                  activeBackgroundColor: AppColors.backgroundColor,
                  activeForegroundColor: currentPage >= 2
                      ? AppColors.highlightColor3
                      : AppColors.textColor,
                  buttonSize: const Size(41, 41),
                  visible: true,
                  closeManually: false,
                  curve: Curves.bounceIn,
                  overlayColor: Colors.black,
                  overlayOpacity: 0.6,
                  elevation: 0,
                  openCloseDial: isDialOpen,
                  onPress: () {
                    isDialOpen.value = true;
                  },
                  children: [
                    SpeedDialChild(
                        child: currentPage == 2
                            ? const Icon(Icons.manage_accounts_outlined)
                            : const Icon(Icons.manage_accounts),
                        backgroundColor: AppColors.backgroundColor,
                        foregroundColor: currentPage == 2
                            ? AppColors.highlightColor3
                            : AppColors.textColor,
                        label: AppLocalizations.of(context)!.menu_profile,
                        labelStyle: TextStyle(
                            fontSize: 12.0,
                            color: currentPage == 2
                                ? AppColors.highlightColor3
                                : AppColors.textColor),
                        onTap: () => onSpeedDialTap(0)),
                    SpeedDialChild(
                        child: currentPage == 3
                            ? const Icon(Icons.flip_camera_android_outlined)
                            : const Icon(Icons.flip_camera_android),
                        backgroundColor: AppColors.backgroundColor,
                        foregroundColor: currentPage == 3
                            ? AppColors.highlightColor3
                            : AppColors.textColor,
                        label: AppLocalizations.of(context)!.menu_converter,
                        labelStyle: TextStyle(
                            fontSize: 12.0,
                            color: currentPage == 3
                                ? AppColors.highlightColor3
                                : AppColors.textColor),
                        onTap: () => onSpeedDialTap(1)),
                    SpeedDialChild(
                        child: currentPage == 4
                            ? const Icon(Icons.egg_outlined)
                            : const Icon(Icons.egg),
                        backgroundColor: AppColors.backgroundColor,
                        foregroundColor: currentPage == 4
                            ? AppColors.highlightColor3
                            : AppColors.textColor,
                        label: AppLocalizations.of(context)!.menu_ingredients,
                        labelStyle: TextStyle(
                            fontSize: 12.0,
                            color: currentPage == 4
                                ? AppColors.highlightColor3
                                : AppColors.textColor),
                        onTap: () => onSpeedDialTap(2)),
                    SpeedDialChild(
                        child: currentPage == 5
                            ? const Icon(Icons.kitchen_outlined)
                            : const Icon(Icons.kitchen),
                        backgroundColor: AppColors.backgroundColor,
                        foregroundColor: currentPage == 5
                            ? AppColors.highlightColor3
                            : AppColors.textColor,
                        label: AppLocalizations.of(context)!.menu_pantry,
                        labelStyle: TextStyle(
                            fontSize: 12.0,
                            color: currentPage == 5
                                ? AppColors.highlightColor3
                                : AppColors.textColor),
                        onTap: () => onSpeedDialTap(3)),
                    SpeedDialChild(
                        child: currentPage == 6
                            ? const Icon(Icons.local_grocery_store_outlined)
                            : const Icon(Icons.local_grocery_store),
                        backgroundColor: AppColors.backgroundColor,
                        foregroundColor: currentPage == 6
                            ? AppColors.highlightColor3
                            : AppColors.textColor,
                        label: AppLocalizations.of(context)!.menu_grocery,
                        labelStyle: TextStyle(
                            fontSize: 12.0,
                            color: currentPage == 6
                                ? AppColors.highlightColor3
                                : AppColors.textColor),
                        onTap: () => onSpeedDialTap(4))
                  ],
                ))));
  }
}
