import 'package:flutter/material.dart';
import 'package:light/controller/quizcontroller.dart';
import 'package:light/models/carddata.dart';
import 'package:light/providers/courses.dart';
import 'package:light/utils/constants.dart';
import 'package:light/views/widgets/custom_coursetile.dart';
import 'package:light/views/widgets/optionstile.dart';
import 'package:provider/provider.dart';

class CourseList extends StatelessWidget {
  const CourseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Courses',
                      style: Constants.kminTextStyle.copyWith(fontSize: 20)),
                  CircleAvatar(
                    child: Icon(
                      Icons.person,
                      color: Colors.blue.withOpacity(0.1),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  height: 50,
                  width: double.maxFinite,
                  child: Card(
                    color: Colors.blue.withOpacity(0.1),
                    elevation: 0,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                          decoration: InputDecoration(
                              icon: Icon(Icons.search),
                              hintText: 'Find Course')),
                    ),
                  ),
                ),
              ),
              SizedBox(
                  width: double.maxFinite,
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return OptionTile(
                        info: optionTileData[index].info,
                        imageloc: optionTileData[index].imageLoc,
                        colorInfo: optionTileData[index].color!,
                      );
                    },
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: Text('Choose your course',
                    style: Constants.kminTextStyle.copyWith(
                      fontSize: 15,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ChoiceChip(
                                label: Text(index == 0
                                    ? 'All'
                                    : index == 1
                                        ? 'Popular'
                                        : 'New'),
                                selected: true,
                              ),
                            ))),
              ),
              Expanded(
                  child: FutureProvider(
                create: (context) =>
                    Provider.of<QuizController>(context).fetchCourses(),
                child: Consumer<QuizController>(
                    builder: (BuildContext context, value, Widget? child) {
                  return ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) => CustomCourseTile(
                            title: value.questions[index].question,
                          ));
                }),
                initialData: const [],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

var quizController = QuizController();
