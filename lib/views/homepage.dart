import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/enums/PagesEnum.dart';
import 'package:light/notifiers/pagination_notifiers.dart';
import 'package:light/styledWidget/calenderSideScreen.dart';
import 'package:light/views/dashboards/dashboard.dart';
import 'package:light/views/notifications.dart';
import 'package:light/views/viewteachersdetails.dart';
import 'package:light/views/viewstudents_detail_screen.dart';
import '../styledWidget/mydrawer.dart';
import '../utils/navigationutil.dart';
import 'dashboards/managementscreen.dart';

final pageNavProvider = StateNotifierProvider<PaginationNotifier, PageLocale>(
    (ref) => PaginationNotifier());

class HomePage extends ConsumerWidget {
  static String id = 'HomePage';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setPage = ref.watch(pageNavProvider);
    return MainHomePage(setPage: setPage);
  }
}

class MainHomePage extends StatelessWidget {
  const MainHomePage({
    Key? key,
    required this.setPage,
  }) : super(key: key);

  final PageLocale setPage;

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Row(
        children: [
          Visibility(
              visible: screensize.width > 500,
              child: screensize.width > 500
                  ? Expanded(
                      child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 5),
                      child: Consumer(
                        builder: (context, ref, child) {
                          return StyledDrawer(
                            setPage: setPage,
                            user: null,
                          );
                        },
                      ),
                    ))
                  : SizedBox()),
          Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: ScreenReturn(
                  pagelocale: setPage,
                  dashboard: const HomeDashboard(),
                  management: const StatisticsScreen(),
                  students: const ViewStudentsScreen(),
                  teachers: const ViewTeachersScreen(),
                  schedule: const ScheduleScreen(),
                ),
              )),
          Visibility(
              visible: screensize.width > 900,
              child: screensize.width > 900
                  ? Expanded(flex: 2, child: CalenderColumn())
                  : SizedBox())
        ],
      ),
    );
  }
}
