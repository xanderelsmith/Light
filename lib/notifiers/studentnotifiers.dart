import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/models/student/student.dart';

class StudentNotifier extends StateNotifier<List<Student>> {
  StudentNotifier() : super([]);
  updateStudents(List<Student> students) {
    state.addAll(students);
  }
}

final studentNotifierProvider =
    StateNotifierProvider<StudentNotifier, List<Student>>((ref) {
  return StudentNotifier();
});
