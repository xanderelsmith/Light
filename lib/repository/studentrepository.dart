import 'package:light/models/student/student.dart';
import 'package:light/services/user_fetch.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class StudentRepository<Students> {
  final UserFetchServices _userFetchServices = UserFetchServices();
  Future<List<Student>> fetchStudents() async {
    List<ParseObject> students = await _userFetchServices.fetchStudents();
    return students
        .map((e) => Student(
            user: e['user'],
            name: e['name'],
            objectId: e['objectId'],
            section: e['section']))
        .toList();
  }
}
