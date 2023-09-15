import 'package:flutter/material.dart';

import '../widgets/tabbar.dart';

class HomeAssessmentTab extends StatelessWidget {
  const HomeAssessmentTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            DesktopTabBarName(
              tabname: 'Recent Assessment',
              onTap: () {},
            ),
            Expanded(
                child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => const Card(
                  child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Danny Chest'),
                      Text('Mathematics'),
                      CircleAvatar(
                        radius: 12,
                        child: Center(child: Text('A')),
                      ),
                    ]),
              )),
            )),
          ],
        ),
      ),
    );
  }
}
