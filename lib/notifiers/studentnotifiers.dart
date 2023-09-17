import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/models/student/student.dart';
import 'package:light/services/storage/hivedb_functions.dart';

class StudentNotifier extends StateNotifier<List<Student>> {
  StudentNotifier() : super([]);
  void assign(List data) {
    state = [...data];
  }

  void delete({required int index, sectionsHiveData}) {
    final detailsListValue = state;
    detailsListValue.removeAt(index);
    state = [...detailsListValue];
    removeToHiveDbData(index: index, hiveData: sectionsHiveData);

    log(state.length.toString());
  }

  updateStudents(List<Student> students) {
    state.addAll(students);
  }
}

final studentNotifierProvider =
    StateNotifierProvider<StudentNotifier, List<Student>>((ref) {
  return StudentNotifier();
});
List refreshSections(eventsHiveData, {List? updateList}) {
  final List data = eventsHiveData.keys.map((key) {
    final item = eventsHiveData.get(key);
    return {
      'key': key,
      'name': item['name'],
      'objectId': item['objectId'],
      'user': item['user'],
      'section': item['section']
    };
  }).toList();
  print(data);

  return data;
}

final studentsProvider =
    StateNotifierProvider.autoDispose<StudentNotifier, List<Student>>((ref) {
  return StudentNotifier();
});

List refreshStudents(eventsHiveData, {List? updateList}) {
  final List data = eventsHiveData.keys.map((key) {
    final item = eventsHiveData.get(key);
    return {
      'key': key,
      'name': item['name'],
      'objectId': item['objectId'],
      'user': item['user'],
      'section': item['section'],
    };
  }).toList();
  print(data);

  return data;
}
