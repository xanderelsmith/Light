import 'package:flutter/material.dart';

class Styles {
  static LinearGradient myOrangeGradient = LinearGradient(colors: [
    const Color(0xffF9D213),
    primaryThemeDarkColor,
  ]);

  static TextStyle kmaxTextStyle = const TextStyle(
    fontSize: 100,
  );
  static TextStyle kminTextStyle = const TextStyle(fontSize: 40);

  static TextStyle titleTextStyle = const TextStyle(
    fontSize: 25,
  );
  static TextStyle text = const TextStyle(
      fontStyle: FontStyle.normal, fontSize: 20, fontWeight: FontWeight.bold);
  static TextStyle specialTextStyle = Styles.text.copyWith(
    fontSize: 15,
  );
  static Color kdarkcontainerColor = const Color(0xff191f25);
  static Color kdarkbackgroundColor = const Color(0xff353c44);
  static Color kwhiteShade = const Color(0xffffffff);
  static Color secondaryThemeColor = const Color.fromRGBO(255, 144, 0, 1);
  static Color primaryThemeColor = const Color(0xfffed52b);
  static Color primaryThemeDarkColor = const Color(0xfff6b71e);
}
