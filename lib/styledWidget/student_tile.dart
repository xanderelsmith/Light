import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/styledWidget/specialtextfield.dart';
import 'package:light/utils/dummydata.dart';
import 'package:light/views/widgets/tabbar.dart';

class StudentGenderTab extends ConsumerStatefulWidget {
  const StudentGenderTab({
    super.key,
    required this.tableName,
  });
  final String tableName;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StudentGenderTabState();
}

class _StudentGenderTabState extends ConsumerState<StudentGenderTab> {
  List<String> newOrderedList = [];
  @override
  void initState() {
    newOrderedList = dummyData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: DesktopTabBarName(
                customColor: Colors.purple,
                tabname: widget.tableName,
                showIcon: false),
          ),
          SizedBox(
            height: 30,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 2.0,
              ),
              child: SpecialTextfield(
                  onChanged: (p0) {
                    setState(() {
                      newOrderedList = dummyData
                          .where((String element) => element
                              .toLowerCase()
                              .characters
                              .containsAll(p0.characters.toLowerCase()))
                          .toList();
                      if (p0.isEmpty) {
                        newOrderedList = dummyData;
                      }
                    });
                  },
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.only(left: 20),
                      hintText: '',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)))),
            ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisExtent: 50),
                    //always increase the list length by 1 to compensate for the addSection feature
                    itemCount: newOrderedList.length,
                    itemBuilder: (context, index) => Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: SizedBox(
                            height: 50,
                            child: Row(children: [
                              const CircleAvatar(
                                radius: 15,
                              ),
                              Text(newOrderedList[index].toString())
                            ]),
                          ),
                        )))),
          ),
        ],
      ),
    );
  }
}
