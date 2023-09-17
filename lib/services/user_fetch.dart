import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class UserFetchServices {
  Future<List<ParseObject>> fetchStudents() async {
    final queryUsers = QueryBuilder<ParseUser>(ParseUser.forQuery());

    final ParseResponse apiResponse = await queryUsers.query<ParseObject>();

    if (apiResponse.success && apiResponse.results != null) {
      log(apiResponse.results.toString());
      return apiResponse.results as List<ParseObject>;
    } else {
      return [];
    }
  }
}
