import 'package:flutter/material.dart';

void styledDialog(
    {required BuildContext context,
    required Widget message,
    required String title,
    SnackBar? customSnackBar,
    Duration? duration}) {
  showDialog(
      context: context,
      builder: ((context) =>
          AlertDialog(title: Text(title), content: message)));
}

void styledSnackBar(
    {required BuildContext context,
    String? message,
    SnackBar? customSnackBar,
    Duration? duration}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(customSnackBar ??
      SnackBar(
        content: Text(message ?? ''),
        duration: duration ?? const Duration(seconds: 4),
      ));
}

ButtonStyle chipStyleButton = ElevatedButton.styleFrom(
    fixedSize: const Size(250, 40),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)));
