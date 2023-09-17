import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Student {
  const Student({
    required this.user,
    required this.name,
    required this.objectId,
    required this.section,
  });
  final String name;
  final String objectId;
  final ParseObject user;
  final String section;

  Map toJson() => {
        'name': name,
        'objectId': objectId,
        'user': user,
        'section': section,
      };
  Student fromJson(Map data) => Student(
      user: data['user'],
      name: data['name'],
      objectId: data['objectId'],
      section: data['section']);
}
