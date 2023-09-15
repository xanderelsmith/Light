import 'package:flutter/material.dart';
import 'package:light/styledWidget/student_tile.dart';
import 'package:light/views/dashboards/managementscreen.dart';
import 'package:light/views/widgets/tabbar.dart';

class AllStudentsTab extends StatelessWidget {
  const AllStudentsTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 15.0),
          child: DesktopTabBarName(tabname: 'All Students', showIcon: false),
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              StudentGenderTab(tableName: 'Male'),
              SizedBox(width: 100),
              StudentGenderTab(tableName: 'Female'),
            ],
          ),
        ),
      ],
    );
  }
}
