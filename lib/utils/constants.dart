import 'package:flutter/material.dart';
import 'package:light/models/carddata.dart';

class Constants {
  static LinearGradient myOrangeGradient = LinearGradient(colors: [
    const Color(0xffF9D213),
    primaryThemeDarkColor,
  ]);

  static TextStyle kmaxTextStyle = const TextStyle(
    fontSize: 100,
  );
  static const TextStyle kminTextStyle =
      TextStyle(fontWeight: FontWeight.w700, fontSize: 15);
  static TextStyle titleTextStyle = const TextStyle(
    fontSize: 25,
  );
  static TextStyle text = const TextStyle(
      fontStyle: FontStyle.normal, fontSize: 20, fontWeight: FontWeight.bold);

  static const Color kdarkcontainerColor = Color(0xff191f25);
  static const Color kdarkbackgroundColor = Color(0xff353c44);
  static const Color kwhiteShade = Color(0xffffffff);
  static const Color secondaryThemeColor = Color(0xff3D5CFF);
  static const Color primaryThemeColor = Color(0xff3D5CFF);
  static const Color primaryThemeDarkColor = Color(0xff3D5CFF);
  static const Color blueCard = Color(0xffCEECFE);
  static const String appname = 'Light';
}

const List<CardData> kCardInfo = [
  CardData(
    info: 'What do you \nwant to learn\n today',
    imageLoc: 'images/slide1.png',
  ),
  CardData(
    info: 'Take a free \nAssessment',
    imageLoc: 'images/slide2.png',
  ),
];

const List<CardData> optionTileData = [
  CardData(
      imageLoc: 'images/languageicon.png',
      info: 'Language',
      color: Colors.blueAccent),
  CardData(
      imageLoc: 'images/paintingicon.png',
      info: 'Painting',
      color: Colors.pinkAccent),
];
