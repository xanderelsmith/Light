import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/models/notifications.dart';
import 'package:light/notifiers/notifications_repo.dart';
import 'package:light/services/storage/hivedb_functions.dart';
import 'package:light/utils/constants.dart';
import 'package:light/utils/notifications_dialog.dart';
import 'package:light/views/widgets/tabbar.dart';

class ActiveNotificationscreen extends ConsumerStatefulWidget {
  const ActiveNotificationscreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ActiveNotificationscreenState();
}

class _ActiveNotificationscreenState
    extends ConsumerState<ActiveNotificationscreen> {
  DateTime? dateTime;
  List<ActiveNotification> notifications = [];
  final notificationsHiveData = Hive.box(HiveDb.notificationsBox);
  @override
  void initState() {
    super.initState();
    notifications = refreshNotifications(notificationsHiveData)
        .map((e) => ActiveNotification(
            createdDate: e['createdDate'],
            description: e['description'],
            title: e['title']))
        .toList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.watch(activenotificationProvider.notifier).assign(notifications);
  }

  @override
  Widget build(BuildContext context) {
    notifications = ref.watch(activenotificationProvider);
    final notificationsHiveData = Hive.box(HiveDb.notificationsBox);
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) =>
                      const NotificationsDialog(isEdited: false));
            },
            tooltip: 'Your students will see all notifications added here',
            icon: const Icon(Icons.notification_add_outlined),
            label: const Text('Add a notification')),
        body: Column(children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: DesktopTabBarName(tabname: 'Weekly News/Notifications'),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) => Card(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 11,
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Card(
                                  child: SizedBox(
                                width: 40,
                                height: 40,
                                child: Icon(Icons.circle_notifications_sharp,
                                    color: Colors.purpleAccent),
                              )),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(notifications[index].title),
                                Text(notifications[index].description,
                                    style: Constants.defaultTextStyle),
                              ],
                            )
                          ],
                        ),
                      ))))
        ]));
  }
}
