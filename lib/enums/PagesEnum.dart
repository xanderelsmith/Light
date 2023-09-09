import 'package:flutter/material.dart';

enum PageLocale {
  dashboard('Dashboard', Icons.dashboard_outlined),
  schedule('Schedule', Icons.calendar_today_outlined),
  students('Students', Icons.add_reaction_outlined),
  teachers('Teachers', Icons.group_add_outlined),
  management('Management', Icons.bar_chart_outlined);

  final String value;
  final IconData iconData;
  const PageLocale(this.value, this.iconData);
}

PageLocale homePageEnum(index) {
  return index == 0
      ? PageLocale.dashboard
      : index == 1
          ? PageLocale.schedule
          : index == 2
              ? PageLocale.management
              : index == 3
                  ? PageLocale.students
                  : PageLocale.teachers;
}
