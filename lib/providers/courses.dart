import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Courses {
  static Future<List<ParseObject>> pullAllCourses() async {
    QueryBuilder<ParseObject> queryCourses =
        QueryBuilder<ParseObject>(ParseObject('Quiz'))
          ..includeObject(['institution']);

    final ParseResponse apiResponse = await queryCourses.query<ParseObject>();
    return apiResponse.results as List<ParseObject>;
  }
}
