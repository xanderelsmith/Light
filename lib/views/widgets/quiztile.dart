import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class QuizTile extends StatelessWidget {
  const QuizTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Card(
        child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 11,
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: CircleAvatar(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Intro to data science'),
              Text('mr danny rev', style: Constants.defaultTextStyle),
            ],
          )
        ],
      ),
    ));
  }
}
