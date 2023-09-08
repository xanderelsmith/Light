import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class QuizDataServices {
  static Future<List<ParseObject>> pullQuizMaterialsBasedOnLevel(
      {required String institutionId, required int level}) async {
    QueryBuilder<ParseObject> queryPublisher =
        QueryBuilder<ParseObject>(ParseObject('Quiz'));
    final ParseResponse apiResponse = await queryPublisher.query<ParseObject>();

    if (apiResponse.success && apiResponse.results != null) {
      log(apiResponse.results.toString());
      return apiResponse.results as List<ParseObject>;
    }
    return [];
  }
}
