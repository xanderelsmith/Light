import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/controller/studentscontroller.dart';
import 'package:light/models/student/student.dart';
import 'package:light/repository/studentrepository.dart';
import 'package:light/views/subviews/management/section_tab.dart';
import 'package:light/views/subviews/management/student_tab.dart';

class WardsManagerScreen extends ConsumerWidget {
  const WardsManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: const Text('Sync Data'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Expanded(flex: 3, child: SectionTab()),
              Expanded(
                  flex: 7, child: AllStudentsTab()),
            ],
          ),
        ));
  }
}
