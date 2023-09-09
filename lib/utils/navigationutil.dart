import 'package:flutter/material.dart';

import '../enums/PagesEnum.dart';
import '../views/dashboards/dashboard.dart';

class ScreenReturn extends StatelessWidget {
  final PageLocale pagelocale;
  final Widget dashboard;
  final Widget schedule;
  final Widget management;
  final Widget students;
  final Widget teachers;

  const ScreenReturn(
      {Key? key,
      required this.pagelocale,
      required this.dashboard,
      required this.schedule,
      required this.management,
      required this.students,
      required this.teachers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return pagelocale == PageLocale.dashboard
        ? dashboard
        : pagelocale == PageLocale.schedule
            ? schedule
            : pagelocale == PageLocale.management
                ? management
                : pagelocale == PageLocale.students
                    ? students
                    : teachers;
  }
}
