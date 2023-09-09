import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          tooltip: 'Your students will see all notifications added here',
          icon: Icon(Icons.notification_add_outlined),
          label: Text('Add a schedule')),
      body: Row(children: [
        Expanded(
          flex: 2,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Active Tasks',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ]),
        ),
        Expanded(
          child: Container(),
        )
      ]),
    );
  }
}
