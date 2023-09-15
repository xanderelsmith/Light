import 'package:flutter/material.dart';
import 'package:light/styledWidget/sectiontile.dart';
import 'package:light/styledWidget/specialtextfield.dart';
import 'package:light/views/widgets/tabbar.dart';

class StudentGenderTab extends StatelessWidget {
  const StudentGenderTab({
    super.key,
    required this.tableName,
  });
  final String tableName;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: DesktopTabBarName(
                customColor: Colors.purple,
                tabname: tableName,
                showIcon: false),
          ),
          SizedBox(
            height: 30,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 2.0,
              ),
              child: SpecialTextfield(
                  onChanged: (p0) {},
                  controller: TextEditingController(),
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
                child: ListView.builder(
                    //always increase the list length by 1 to compensate for the addSection feature
                    itemCount: 11,
                    itemBuilder: (context, index) => const Card(
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: SizedBox(
                            height: 50,
                            child: Row(children: [
                              CircleAvatar(
                                radius: 15,
                              )
                            ]),
                          ),
                        )))),
          ),
        ],
      ),
    );
  }
}
