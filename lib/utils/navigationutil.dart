import 'package:flutter/material.dart';

import '../enums/PagesEnum.dart';

class ScreenReturn extends StatelessWidget {
  final PageLocale pagelocale;
  final Widget dashboard;
  final Widget notification;
  final Widget management;
  final Widget courseresources;
  final Widget? teachers;

  const ScreenReturn(
      {Key? key,
      required this.pagelocale,
      required this.dashboard,
      required this.notification,
      required this.management,
      required this.courseresources,
      this.teachers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return pagelocale == PageLocale.dashboard
        ? dashboard
        : pagelocale == PageLocale.notification
            ? notification
            : pagelocale == PageLocale.students
                ? courseresources
                : management;
  }
}
