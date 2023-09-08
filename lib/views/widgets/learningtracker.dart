import 'package:flutter/material.dart';
import 'package:light/utils/constants.dart';

class LearningTracker extends StatelessWidget {
  const LearningTracker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Learned today'),
                Text('My Courses',
                    style: TextStyle(
                      color: Colors.blue,
                    )),
              ]),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text.rich(TextSpan(
                  text: '46min',
                  style: Constants.text.copyWith(fontSize: 20),
                  children: [
                    TextSpan(
                        text: '\t/46min',
                        style: Constants.kminTextStyle.copyWith(fontSize: 10))
                  ]))),
          Container(
              height: 10,
              color: Colors.white,
              width: double.maxFinite,
              child: Container(
                  decoration: const BoxDecoration(
                      gradient:
                          LinearGradient(colors: [Colors.white, Colors.red])),
                  height: 10,
                  width: 200)),
        ]),
      ),
    );
  }
}
