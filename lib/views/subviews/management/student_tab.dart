import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/styledWidget/student_tile.dart';
import 'package:light/views/widgets/tabbar.dart';

class AllStudentsTab extends ConsumerWidget {
  const AllStudentsTab({
    super.key,
    required this.studentsData,
  });
  final AsyncValue studentsData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return studentsData.when(
        data: (data) => const Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: DesktopTabBarName(
                      tabname: 'All Students', showIcon: false),
                ),
                StudentGenderTab(tableName: 'Search'),
              ],
            ),
        error: (error, stackTrace) =>
            TextButton(onPressed: () {}, child: const Text('Reload')),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
