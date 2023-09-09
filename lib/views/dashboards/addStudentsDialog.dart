
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/models/students_data_model.dart';
import '../../controller/addPatientController.dart';

final addstudentlistProvider =
    StateNotifierProvider<StudentsListNotifier, List<StudentsModel>>(
        (ref) => StudentsListNotifier());

class AddStudentDialog extends ConsumerWidget {
  const AddStudentDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog();
  }
}
