import 'package:flutter/material.dart';

import '../widgets/tabbar.dart';

class AllCourses extends StatelessWidget {
  const AllCourses({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              DesktopTabBarName(
                tabname: 'Courses',
                onTap: () {},
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => const Card(
                    child: ListTile(
                  title: Text('ABE101'),
                )),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
