// Get all events from the database
import 'dart:developer';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/models/calendermodels/event_data_model.dart';
import 'package:light/services/storage/hivedb_functions.dart';
import 'package:light/utils/utils.dart';

class EventCalenderRepository extends StateNotifier<List<EventData>> {
  EventCalenderRepository() : super([]);

  void saveEvent({required EventData value, eventsHiveData}) {
    addToHiveDbData(value.toJson(), eventsHiveData);

    state = [...state, value];

    state = refreshEvents(eventsHiveData)
        .map((e) =>
            EventData(date: e['date'], info: e['info'], title: e['title']))
        .toList();
    eventDateSorter(state);
    log(state.length.toString());
  }

  void clearData() {
    state.clear();
  }

  void assign(List<EventData> data) {
    for (var element in data) {
      log(element.toJson().toString());
    }
    eventDateSorter(data);
    state = [...data];
  }

  void delete({required int index, eventsHiveData}) {
    final detailsListValue = state;
    detailsListValue.removeAt(index);
    state = [...detailsListValue];
    state.sort((a, b) => a.date.month.compareTo(b.date.month));
    removeToHiveDbData(index: index, hiveData: eventsHiveData);
    eventDateSorter(state);
    log(state.length.toString());
  }
}

final eventsProvider =
    StateNotifierProvider.autoDispose<EventCalenderRepository, List<EventData>>(
        (ref) {
  return EventCalenderRepository();
});

List refreshEvents(eventsHiveData, {List? updateList}) {
  final List data = eventsHiveData.keys.map((key) {
    final item = eventsHiveData.get(key);
    return {
      'key': key,
      'title': item['title'],
      'info': item['info'],
      'date': item['date']
    };
  }).toList();
  print(data);

  return data;
}
