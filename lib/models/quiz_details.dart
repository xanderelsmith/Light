import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class QuizDetails {
  final String quizname;
  final List reactions;
  final ParseUser quizauthor;
  final String description;
  final ParseObject fullquizparsedata;

  QuizDetails({
    required this.description,
    required this.reactions,
    required this.fullquizparsedata,
    required this.quizname,
    required this.quizauthor,
  });
}

///a many-many query retrieving all parent data of a relation
Future<List<ParseObject>> pullSingleQuizBasedCourses(
    {required ParseObject quiz}) async {
  QueryBuilder<ParseObject> queryquiz =
      QueryBuilder<ParseObject>(ParseObject('Courses'))
        ..includeObject(['owner', 'institution', 'linkedquiz'])
        ..whereContainedIn('linkedquiz', [quiz])
        ..orderByAscending('updatedAt');

  final ParseResponse apiResponse = await queryquiz.query<ParseObject>();
  log(apiResponse.results.toString());
  if (apiResponse.success && apiResponse.results != null) {
    log(apiResponse.results.toString());
    return apiResponse.results as List<ParseObject>;
  }
  return <ParseObject>[];
}
