import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/models/students_data_model.dart';
import 'package:light/styledWidget/sectiontile.dart';
import 'package:light/styledWidget/specialtextfield.dart';
import 'package:light/views/subviews/management/section_tab.dart';
import 'package:light/views/subviews/management/student_tab.dart';
import 'package:light/views/widgets/tabbar.dart';

import '../../controller/addPatientController.dart';

final addstudentlistProvider =
    StateNotifierProvider<StudentsListNotifier, List<StudentsModel>>(
        (ref) => StudentsListNotifier());

class WardsManagerScreen extends ConsumerWidget {
  const WardsManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: const Text('Add a Student'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(flex: 3, child: SectionTab()),
              Expanded(flex: 7, child: AllStudentsTab()),
            ],
          ),
        ));
  }
}
