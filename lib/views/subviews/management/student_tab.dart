import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/controller/studentscontroller.dart';
import 'package:light/models/student/student.dart';
import 'package:light/notifiers/studentnotifiers.dart';
import 'package:light/services/storage/hivedb_functions.dart';
import 'package:light/styledWidget/student_tile.dart';
import 'package:light/views/widgets/tabbar.dart';

class AllStudentsTab extends ConsumerStatefulWidget {
  const AllStudentsTab({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllStudentsTabState();
}

class _AllStudentsTabState extends ConsumerState<AllStudentsTab> {
  DateTime? dateTime;
  List<Student> students = [];
  final studentsHiveData = Hive.box(HiveDb.students);
  @override
  void initState() {
    super.initState();
    students = refreshStudents(studentsHiveData)
        .map((data) => Student(
            user: data['user'],
            name: data['name'],
            objectId: data['objectId'],
            section: data['section']))
        .toList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.watch(studentsProvider.notifier).assign(students);
  }

  @override
  Widget build(BuildContext context) {
    final studentsData = ref.watch(studentsFutureProvider);
    students = ref.watch(studentsProvider);
    print(students);
    final studentsHiveData = Hive.box(HiveDb.students);
    return studentsData.when(
        data: (data) => Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: DesktopTabBarName(
                      tabname: 'All Students', showIcon: false),
                ),
                StudentGenderTab(tableName: 'Search', students: students),
              ],
            ),
        error: (error, stackTrace) =>
            TextButton(onPressed: () {}, child: Text(error.toString())),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
