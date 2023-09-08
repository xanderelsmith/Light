import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Quiz {
  static Future<List<ParseObject>> pullAllQuizes() async {
    QueryBuilder<ParseObject> queryCourses =
        QueryBuilder<ParseObject>(ParseObject('Quiz'));

    final ParseResponse apiResponse = await queryCourses.query<ParseObject>();
    return apiResponse.results as List<ParseObject>;
  }
}
