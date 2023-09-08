import 'package:flutter/material.dart';
import 'package:light/utils/constants.dart';

class MeetupCard extends StatelessWidget {
  const MeetupCard({
    required this.screensize,
  });
  final Size screensize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 211, 187, 236),
              borderRadius: BorderRadius.circular(10)),
          height: 200,
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Meetup',
                    style: Constants.kminTextStyle.copyWith(
                        fontSize: 20,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.w600),
                  ),
                  FittedBox(
                      child: Text(
                    'Live-Class /Online exchange of learning\n experiences',
                    style: Constants.kminTextStyle.copyWith(
                        fontSize: 11,
                        color: Colors.deepPurpleAccent,
                        fontWeight: FontWeight.w600),
                  ))
                ],
              ),
              Image.asset('images/meetup.png'),
            ],
          ),
        ));
  }
}
