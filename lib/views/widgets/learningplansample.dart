import 'package:flutter/material.dart';
import 'package:light/utils/constants.dart';

class LearningPlanSampleQuizDisplay extends StatelessWidget {
  const LearningPlanSampleQuizDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) => ListTile(
              title: Text('Packaging'),
              trailing: Text.rich(TextSpan(
                  style: TextStyle(color: Colors.blueAccent),
                  text: '40',
                  children: [
                    TextSpan(
                        text: '\t/46',
                        style: Constants.kminTextStyle
                            .copyWith(color: Colors.black38, fontSize: 11))
                  ])),
            ));
  }
}
