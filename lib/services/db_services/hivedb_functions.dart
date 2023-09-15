import 'package:hive/hive.dart';

Future<void> addToHiveDbData(
    Map<String, dynamic> newEvent, eventsHiveData) async {
  await eventsHiveData.add(newEvent);
}

Future<void> removeToHiveDbData(
    {index, required Box<dynamic> modelHiveData}) async {
  await modelHiveData.deleteAt(index);
}

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

Future<void> hivedbEndPoint() async {
  await Hive.openBox(HiveDb.eventsbox);
  await Hive.openBox(HiveDb.quizbox);
  await Hive.openBox(HiveDb.sections);
}

class HiveDb {
  static String sections = 'sections';
  static String quizbox = 'quiz_box';
  static String eventsbox = 'events_box';
}
