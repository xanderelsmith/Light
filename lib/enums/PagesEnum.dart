import 'package:flutter/material.dart';

enum PageLocale {
  dashboard('Dashboard', Icons.home_filled),
  schedule('Schedule', Icons.calendar_today_outlined),
  students('Courses', Icons.book),

  management('Management', Icons.bar_chart_outlined);

  final String value;
  final IconData iconData;
  const PageLocale(this.value, this.iconData);
}

PageLocale homePageEnum(index) {
  return index == 0
      ? PageLocale.dashboard
      : index == 1
          ? PageLocale.management
          : index == 2
              ? PageLocale.students
              : PageLocale.schedule;
}
