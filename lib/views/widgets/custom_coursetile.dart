import 'package:flutter/material.dart';

class CustomCourseTile extends StatelessWidget {
  const CustomCourseTile({required this.title, super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
            width: 70,
            height: 70,
            child: Card(
              color: Colors.red,
            )),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 4,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text(title)],
          ),
        )
      ]),
    );
  }
}
