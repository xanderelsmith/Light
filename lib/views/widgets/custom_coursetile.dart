import 'package:flutter/material.dart';

class CustomCourseTile extends StatelessWidget {
  const CustomCourseTile({super.key});

  @override
  Widget build(BuildContext context) {
    final data= Provider
    return const SizedBox(
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
            width: 70,
            height: 70,
            child: Card(
              color: Colors.red,
            )),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 4,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text('data')],
          ),
        )
      ]),
    );
  }
}
