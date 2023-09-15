import 'package:flutter/material.dart';
import 'package:light/utils/constants.dart';
import 'package:light/views/subviews/edit_quiz_screen.dart';

class CourseAsset extends StatelessWidget {
  const CourseAsset({
    super.key,
    this.index,
    required this.color,
  });
  final int? index;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: double.maxFinite,
        width: 150,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
            12,
          )),
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          surfaceTintColor: Colors.black,
          color:
              index != null ? color : Theme.of(context).cardColor.withBlue(150),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateQuizScreen(),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: index == null
                  ? Center(
                      child: Icon(
                        Icons.add_circle_outline,
                        size: 100,
                        color: color.withOpacity(0.7),
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                child: Container(
                                  height: 100,
                                  width: double.maxFinite / 1.1,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .cardColor
                                        .withBlue(150),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                              const Text('data'),
                              const Text('12 lessons'),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Constants.secondaryColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child:
                                  const Icon(Icons.arrow_forward_ios_rounded),
                            ),
                          ],
                        )
                      ],
                    ),
            ),
          ),
        ));
  }
}
