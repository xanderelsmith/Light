import 'package:flutter/material.dart';

import 'illustration.dart';

List<Illustration> killustrationPage = [
  const Illustration(
      image: 'images/classroom.png',
      details: 'Automate your school management process',
      title: 'School management resource'),
  const Illustration(
      image: 'images/qualify.png',
      title: 'Topnotch Quiz creator',
      details: 'Make learning easier by creating quiz-based materials'),
  const Illustration(
      image: 'images/foldhand.png',
      title: 'Take your institution online',
      details:
          'Take a giant leap by investing in the right technology for your institution'),
];
double kSmallheight2 = 30;
const konboardingDuration = Duration(milliseconds: 500);
const kAnimationDuration = Duration(milliseconds: 40);
const Color kPrimaryColor = Color(0xffff2400);
const Color kbackgroundColor = Color(0xff3f3242);
const Color kwhiteShade = Color(0xffffffff);
bool value = false;
Color lightmodeColor = Colors.grey.withOpacity(0.4);
int slidervalue = 0;

// ignore: camel_case_types
class kMythemeModes {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColorDark: Colors.white,
    appBarTheme: AppBarTheme(color: lightmodeColor),
    focusColor: kPrimaryColor,
    colorScheme: const ColorScheme.light(primary: kPrimaryColor),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
      backgroundColor: const Color(0xff000116),
      appBarTheme: const AppBarTheme(color: kPrimaryColor, elevation: 0),
      colorScheme: const ColorScheme.dark(primary: kPrimaryColor));

  static ThemeData desktoplightTheme = ThemeData.light().copyWith(
    textButtonTheme: TextButtonThemeData(),
    primaryColorDark: Colors.white,
    appBarTheme: AppBarTheme(color: lightmodeColor, elevation: 0),
    focusColor: kPrimaryColor,
    colorScheme: const ColorScheme.light(primary: kPrimaryColor),
  );

  static ThemeData desktopdarkTheme = ThemeData.dark().copyWith(
      backgroundColor: const Color(0xff000116),
      appBarTheme: const AppBarTheme(color: kPrimaryColor, elevation: 0),
      colorScheme: const ColorScheme.dark(primary: kPrimaryColor));
}

String name = 'Miranda';
double ksliderCount = 60;
double kzoomValue = 0;
String ksubmittedphoneNo = '';

class kStatus {
  Image profilePic;
  String? name;
  Image? image;
  final post;
  kStatus({
    this.image,
    this.name,
    this.post,
    required this.profilePic,
  });
}

double otpHeight = 50;
double knavigationSize = 17;
const KappId = 'RphzqBv6ywUZewBDGdUrZv7mPrpGEUwGw9PSoWBb';
const KclientKey = 'FofuQKqrOFpIO2TbOvisoBO9qTlirNCMvkaLLXzV';
const keyParseServerUrl = 'https://parseapi.back4app.com';
String personName = 'Kyle sarah';

class userClass {
  Color? color;
  final String classState;
  userClass({this.color, required this.classState});
}

List<userClass> userStatus = [
  userClass(classState: 'Jss I', color: Colors.purple),
  userClass(classState: 'Jss II', color: Colors.indigo),
  userClass(classState: 'Jss III', color: Colors.blue),
  userClass(classState: 'Sss I', color: Colors.yellow),
  userClass(classState: 'SSS II', color: Colors.orange),
  userClass(classState: 'Sss III', color: Colors.red),
  userClass(classState: 'Admin', color: Colors.white),
];
int age = 0;

class kdesktopTextStyle {
  static TextStyle kmaxTextStyle = TextStyle(fontSize: kSmallheight2);
  static TextStyle kminTextStyle = TextStyle(fontSize: kSmallheight2 - 10);

  static text(BuildContext context) => TextStyle(
      fontSize: 12,
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.black);
  static TextStyle titleTextStyle =
      const TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.bold);
}

TextStyle kmaxTextStyle = TextStyle(fontSize: kSmallheight2);
TextStyle kminTextStyle = TextStyle(fontSize: kSmallheight2 - 10);
String getDate(DateTime mydate) {
  return '${mydate.toLocal().year}/${mydate.toLocal().month}/${mydate.toLocal().day} Schedule';
}
