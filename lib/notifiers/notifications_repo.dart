import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/models/notifications.dart';
import 'package:light/services/storage/hivedb_functions.dart';
import 'package:light/utils/utils.dart';

class NotificationsNotifier extends StateNotifier<List<ActiveNotification>> {
  NotificationsNotifier() : super([]);

  void saveNotification(
      {required ActiveNotification value, notificationsHiveData}) {
    addToHiveDbData(value.toJson(), notificationsHiveData);
    state = [...state, value];
    state = refreshNotifications(notificationsHiveData)
        .map((e) => ActiveNotification(
            title: e['title'],
            description: e['description'],
            createdDate: e['createdDate']))
        .toList();
    log(state.length.toString());
  }

  void clearData() {
    state.clear();
  }

  void assign(List<ActiveNotification> data) {
    state = [...data];
  }

  void delete({required int index, notificationsHiveData}) {
    final detailsListValue = state;
    detailsListValue.removeAt(index);
    state = [...detailsListValue];
    notificationsDateSorter(state);
  }
}

final activenotificationProvider = StateNotifierProvider.autoDispose<
    NotificationsNotifier, List<ActiveNotification>>((ref) {
  return NotificationsNotifier();
});

List refreshNotifications(eventsHiveData, {List? updateList}) {
  final List data = eventsHiveData.keys.map((key) {
    final item = eventsHiveData.get(key);
    return {
      'key': key,
      'title': item['title'],
      'description': item['description'],
      'createdDate': item['createdDate']
    };
  }).toList();
  print(data);

  return data;
}
