import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ApiretreiveDataBasedServices {
  static Future<List<ParseObject>> pullQuiz(
      {required String institutionId, required int level}) async {
    QueryBuilder<ParseObject> queryPublisher =
        QueryBuilder<ParseObject>(ParseObject('Quiz'))

          ///gets a pointer data
          ..orderByDescending('updatedAt')
          ..excludeKeys(['questions'])

          ..setLimit(500);
    final ParseResponse apiResponse = await queryPublisher.query<ParseObject>();

    if (apiResponse.success && apiResponse.results != null) {
      log(apiResponse.results.toString());
      return apiResponse.results as List<ParseObject>;
    }
    return [];
  }
}
