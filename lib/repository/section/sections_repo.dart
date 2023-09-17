// Get all sections from the database
import 'dart:developer';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/models/section/sectionmodel.dart';

import 'package:light/services/storage/hivedb_functions.dart';

class LocalSectionStorageRepo extends StateNotifier<List<Section>> {
  LocalSectionStorageRepo() : super([]);

  void savesection({required Section value, sectionsHiveData}) {
    addToHiveDbData(value.toJson(), sectionsHiveData);
    state = [...state, value];
    state = refreshSections(sectionsHiveData)
        .map((e) => Section(
              createdDate: e['createdDate'],
              description: e['description'],
              name: e['name'],
            ))
        .toList();
    log(state.length.toString());
  }

  void clearData() {
    state.clear();
  }

  void assign(List data) {
    state = [...data];
  }

  void delete({required int index, sectionsHiveData}) {
    final detailsListValue = state;
    detailsListValue.removeAt(index);
    state = [...detailsListValue];
    removeToHiveDbData(index: index, hiveData: sectionsHiveData);

    log(state.length.toString());
  }
}

final sectionProvider =
    StateNotifierProvider.autoDispose<LocalSectionStorageRepo, List<Section>>(
        (ref) {
  return LocalSectionStorageRepo();
});

List refreshSections(eventsHiveData, {List? updateList}) {
  final List data = eventsHiveData.keys.map((key) {
    final item = eventsHiveData.get(key);
    return {
      'key': key,
      'name': item['name'],
      'description': item['description'],
      'createdDate': item['createdDate']
    };
  }).toList();
  print(data);

  return data;
}
