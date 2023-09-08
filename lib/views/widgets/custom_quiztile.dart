import 'package:flutter/material.dart';
import 'package:light/utils/constants.dart';

class CustomQuizTile extends StatelessWidget {
  const CustomQuizTile({required this.title, super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(margin: const EdgeInsets.symmetric(vertical: 10),
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Theme.of(context).cardColor,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
            width: 70,
            height: 70,
            child: Card(
              color: Constants.blueCard,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('images/book.png'),
              ),
            )),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(title,
                  style: Constants.kminTextStyle
                      .copyWith(color: Colors.blueAccent)),
              Text('Light Ed-Inc'),
              Text('250 points')
            ],
          ),
        )
      ]),
    );
  }
}
