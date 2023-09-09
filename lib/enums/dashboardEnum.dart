import 'package:flutter/material.dart';

enum DashBoard {
  students(Icons.people_alt_outlined, 'Students', Colors.amber),
  teachers(Icons.monetization_on_outlined, 'Teachers', Colors.blue);

  final MaterialColor iconcolor;
  final String text;
  final IconData icon;
  const DashBoard(this.icon, this.text, this.iconcolor);
}

