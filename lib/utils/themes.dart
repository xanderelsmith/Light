import 'package:flutter/material.dart';
import 'package:light/utils/constants.dart';

class MythemeModes {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    cardColor: Colors.white,
    primaryColorLight: Constants.primaryThemeDarkColor,
    primaryColorDark: Constants.primaryThemeColor,
    canvasColor: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: Constants.primaryThemeDarkColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: Constants.primaryThemeDarkColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    ),
    appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.grey[100],
        elevation: 0),
    focusColor: Constants.primaryThemeColor,
    colorScheme: ColorScheme.light(primary: Constants.primaryThemeColor),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
      primaryColorLight: Constants.primaryThemeDarkColor,
      primaryColorDark: Constants.primaryThemeColor,
      canvasColor: Constants.kdarkbackgroundColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Constants.kdarkcontainerColor,
      primaryColor: Constants.primaryThemeDarkColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: Constants.primaryThemeColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
      ),
      cardColor: Constants.kdarkbackgroundColor,
      appBarTheme:
          AppBarTheme(color: Constants.kdarkcontainerColor, elevation: 0),
      colorScheme: ColorScheme.dark(
        background: Constants.kdarkcontainerColor,
        primary: Constants.primaryThemeColor,
      ).copyWith(background: Constants.kdarkcontainerColor),
      bottomAppBarTheme:
          BottomAppBarTheme(color: Constants.kdarkbackgroundColor));
}
