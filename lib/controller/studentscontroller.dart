import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/notifiers/studentnotifiers.dart';
import 'package:light/repository/studentrepository.dart';

class StudentController {
  final StudentRepository _studentRepository;
  final WidgetRef _ref;
  StudentController(this._studentRepository, this._ref);

  Future fetchStudents() async {
    final students = await _studentRepository.fetchStudents();
    _ref.read(studentNotifierProvider.notifier).updateStudents(students);
    return students;
  }
}

final studentsFutureProvider = FutureProvider((ref) async {
  return await StudentRepository().fetchStudents().then((value) =>
      ref.read(studentNotifierProvider.notifier).updateStudents(value));
});
