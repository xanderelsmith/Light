import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/db_handler/styles.dart';
import 'package:light/enums/PagesEnum.dart';
import 'package:light/notifiers/pagination_notifiers.dart';
import 'package:light/views/dashboards/dashboard.dart';
import 'package:light/views/notifications.dart';
import 'package:light/views/viewteachersdetails.dart';
import 'package:light/views/viewstudents_detail_screen.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../db_handler/db_services/api_services.dart';
import '../enums/dashboardEnum.dart';
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
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Row(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 20),
            child: Consumer(
              builder: (context, ref, child) {
                return StyledDrawer(
                  setPage: setPage,
                  user: null,
                );
              },
            ),
          )),
          Expanded(
              flex: 5,
              child: ScreenReturn(
                pagelocale: setPage,
                dashboard: const HomeDashboard(),
                management: const StatisticsScreen(),
                students: const ViewStudentsScreen(),
                teachers: const ViewTeachersScreen(),
                schedule: const ScheduleScreen(),
              )),
          Expanded(flex: 2, child: Container())
        ],
      ),
    );
  }
}
