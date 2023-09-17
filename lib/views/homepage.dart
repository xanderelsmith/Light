import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/enums/PagesEnum.dart';
import 'package:light/notifiers/pagination_notifiers.dart';
import 'package:light/styledWidget/calenderSideScreen.dart';
import 'package:light/views/dashboards/dashboard.dart';
import 'package:light/views/notifications_view.dart';
import 'package:light/views/viewteachersdetails.dart';
import 'package:light/views/resource_inventory.dart';
import '../styledWidget/drawer.dart';
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
                  ? SizedBox(
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 5),
                        child: StyledDrawer(
                          setPage: setPage,
                          user: null,
                        ),
                      ))
                  : const SizedBox()),
          Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: ScreenReturn(
                  pagelocale: setPage,
                  dashboard: const HomeDashboard(),
                  management: const WardsManagerScreen(),
                  courseresources: const ResourceInventory(),
                  notification: const ActiveNotificationscreen(),
                ),
              )),
          screensize.width > 900 ? const CalenderColumn() : const SizedBox()
        ],
      ),
    );
  }
}
