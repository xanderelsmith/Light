import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/utils/utils.dart';
import 'package:light/views/subviews/homepage_assessment_tab.dart';
import 'package:light/views/widgets/tabbar.dart';

import '../widgets/course_asset.dart';

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
                                    const CourseAsset(color: Colors.amber),
                                    ...List.generate(
                                        100,
                                        (index) => CourseAsset(
                                              index: index,
                                              color: Colors.accents[
                                                  index.remainder(
                                                      Colors.accents.length)],
                                            )),
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Expanded(child: HomeAssessmentTab()),
            ],
          ),
        ),
      ],
    );
  }
}
