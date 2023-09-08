import 'package:flutter/material.dart';

enum PagesLocale {
  homepage(Icons.grid_view_outlined),
  education(Icons.school_outlined),
  sparksphere(null),
  notifications(Icons.mail_outline),
  institutions(Icons.maps_home_work_outlined);

  final IconData? iconData;
  const PagesLocale(this.iconData);
}

PagesLocale homePageEnum(index) {
  return index == 0
      ? PagesLocale.homepage
      : index == 1
          ? PagesLocale.education
          : index == 2
              ? PagesLocale.sparksphere
              : index == 3
                  ? PagesLocale.notifications
                  : PagesLocale.institutions;
}
