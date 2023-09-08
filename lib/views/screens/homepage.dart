import 'package:flutter/material.dart';
import 'package:light/utils/constants.dart';
import 'package:light/views/widgets/learningplansample.dart';
import 'package:light/views/widgets/learningtracker.dart';
import 'package:light/views/widgets/meetupcard.dart';
import 'package:light/views/widgets/slidecard.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size(double.maxFinite, 200),
            child: Stack(
              children: [
                Container(
                  height: 150,
                  padding: const EdgeInsets.all(20),
                  color: Constants.primaryThemeColor,
                  child: SafeArea(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('HI, Kristin', style: Constants.text),
                              const Text('Let\'s start learning'),
                            ]),
                        const CircleAvatar(child: Icon(Icons.person))
                      ],
                    ),
                  ),
                ),
                Align(
                    alignment: const Alignment(0, 0.5),
                    child: SizedBox(
                        height: 100,
                        width: screensize.width,
                        child: const LearningTracker()))
              ],
            )),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(children: [
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return SlideCardWidget(
                      imageLoc: kCardInfo[index].imageLoc,
                      info: kCardInfo[index].info,
                      screensize: screensize);
                },
              ),
            ),
            const SizedBox(
              height: 130,
              width: double.maxFinite,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Learning Plan',
                      style: Constants.kminTextStyle,
                    ),
                    SizedBox(
                        height: 100, child: LearningPlanSampleQuizDisplay())
                  ]),
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title: Text(
                          'Live-Class /Online meetup feature would roll-out in next version'),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Ok'))
                      ]),
                );
              },
              child: MeetupCard(
                screensize: screensize,
              ),
            )
          ]),
        ));
  }
}
