import 'package:flutter/material.dart';
import 'package:light/styledWidget/sectiontile.dart';
import 'package:light/utils/constants.dart';
import 'package:light/views/widgets/accesscodetile.dart';
import 'package:light/views/widgets/coursestile.dart';
import 'package:light/views/widgets/quiztile.dart';
import 'package:light/views/widgets/tabbar.dart';

/// The application that contains datagrid on it.
class ResourceInventory extends StatefulWidget {
  const ResourceInventory({Key? key}) : super(key: key);

  @override
  State<ResourceInventory> createState() => _ResourceInventoryState();
}

class _ResourceInventoryState extends State<ResourceInventory> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
            child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const DesktopTabBarName(tabname: 'Courses'),
                Expanded(
                    child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 70,
                    maxCrossAxisExtent: 300,
                  ),
                  itemBuilder: (context, index) => const CoursesTile(),
                ))
              ],
            ),
          ),
        )),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      const DesktopTabBarName(tabname: 'Quizes'),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) => const QuizTile(),
                        ),
                      ),
                    ],
                  )),
                  const SizedBox(width: 30),
                  Expanded(
                      child: Column(children: [
                    const DesktopTabBarName(tabname: 'Generated Access Codes'),
                    Expanded(
                        child: ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) =>
                                const AccessCodeTile())),
                  ]))
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
