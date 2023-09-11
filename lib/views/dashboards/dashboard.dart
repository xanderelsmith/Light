import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/views/dashboards/managementscreen.dart';
import 'package:light/views/subviews/edit_quiz_screen.dart';
import 'package:light/views/subviews/homepage_courses-tab.dart';
import 'package:light/views/widgets/tabbar.dart';

class HomeDashboard extends HookConsumerWidget {
  const HomeDashboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var scrollController = ScrollController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SizedBox(
            height: 100,
            child: Card(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DesktopTabBarName(tabname: 'Students', onTap: () {}),
                  Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                            3,
                            (index) => const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: FittedBox(
                                    child: Column(
                                      children: [
                                        CircleAvatar(radius: 24),
                                        Text('Emmanuel Onyeji')
                                      ],
                                    ),
                                  ),
                                ))),
                  ),
                ],
              ),
            )),
          ),
        ),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const DesktopTabBarName(tabname: 'Recent Works'),
                        Expanded(
                          child: SizedBox(
                            height: double.maxFinite,
                            width: double.maxFinite,
                            child: Scrollbar(
                              thumbVisibility: true,
                              controller: scrollController,
                              child: ListView(
                                  controller: scrollController,
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    const QuestionAsset(),
                                    ...List.generate(3,
                                        (index) => QuestionAsset(index: index)),
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: SizedBox(
                child: Row(
                    children: List.generate(
                        2,
                        (index) => index == 0
                            ? Expanded(
                                child: Card(
                                  child: Container(),
                                ),
                              )
                            : const AllCourses())),
              )),
            ],
          ),
        ),
      ],
    );
  }
}

class QuestionAsset extends StatelessWidget {
  const QuestionAsset({
    super.key,
    this.index,
  });
  final int? index;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: double.maxFinite,
        width: 125,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
            12,
          )),
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          color: index == null ? Colors.amberAccent[200] : Colors.grey,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditQuiz(),
                  ));
            },
            child: Center(
                child: index == null
                    ? const Icon(
                        Icons.add_circle_outline,
                        size: 100,
                        color: Colors.grey,
                      )
                    : null),
          ),
        ));
  }
}
