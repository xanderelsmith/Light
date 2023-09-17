import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class UserFetchServices {
  Future<List<ParseObject>> fetchStudents() async {
    QueryBuilder<ParseObject> queryPublisher =
        QueryBuilder<ParseObject>(ParseObject('User'))
          ..whereEqualTo('status', 'student');

    final ParseResponse apiResponse = await queryPublisher.query<ParseObject>();

    if (apiResponse.success && apiResponse.results != null) {
      log(apiResponse.results.toString());
      return apiResponse.results as List<ParseObject>;
    } else {
      return [];
    }
  }
}
