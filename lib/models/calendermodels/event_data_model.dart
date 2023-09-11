import 'package:flutter/material.dart';

class EventData {
  const EventData(
      {required this.date, required this.info, required this.title});
  final TextEditingController title;
  final TextEditingController info;
  final DateTime date;
}
