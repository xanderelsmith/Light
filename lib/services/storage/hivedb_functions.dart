import 'package:hive/hive.dart';

Future<void> addToHiveDbData(Map<String, dynamic> newData, hiveData) async {
  await hiveData.add(newData);
}

Future<void> removeToHiveDbData({index, required Box<dynamic> hiveData}) async {
  await hiveData.deleteAt(index);
}

Future<void> hivedbEndPoint() async {
  await Hive.openBox(HiveDb.eventsbox);
  await Hive.openBox(HiveDb.quizbox);
  await Hive.openBox(HiveDb.sections);
  await Hive.openBox(HiveDb.notificationsBox);
}

class HiveDb {
  static String sections = 'sections';
  static String quizbox = 'quiz_box';
  static String eventsbox = 'events_box';
  static String notificationsBox = 'notifications_box';
}