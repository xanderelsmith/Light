import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/models/quizmodels/created_quiz_viewer_ui/dragandropquizviewer.dart';
import 'package:light/models/quizmodels/created_quiz_viewer_ui/multichoicequizviewer.dart';
import 'package:light/models/quizmodels/created_quiz_viewer_ui/question_model.dart';
import 'package:light/models/quizmodels/created_quiz_viewer_ui/shortanswerquizviewer.dart';

//for monitoring the created quiz list data
class CreatedQuizRepository extends StateNotifier<List<Question>> {
  CreatedQuizRepository() : super([]);

  void addQuiz(Question value) {
    state = [...state, value];
  }

  void clearData() {
    state.clear();
  }

  Map<String, dynamic> validateAiInputData(dynamic inputText) {
    dynamic inputData;
    if (inputText is String) {
      try {
        inputData = json.decode(inputText);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        return {
          'message': 'Invalid JSON format.\n\n\n$e',
          'success': false,
        };
      }
    } else if (inputText is List) {
      inputData = inputText;
    }
    // Parse the input text as JSON

    // Check if inputData is a List
    if (inputData is! List) {
      return {'message': 'Input data is not a List.', 'success': false};
    }

    // Iterate through each map in the inputData list
    for (var i = 0; i < inputData.length; i++) {
      var item = inputData[i];

      // Check if item is a Map
      if (item is! Map) {
        return {'message': 'Item at index $i is not a Map.', 'success': false};
      }

      // Check if category exists and its value is either "shortTextAnswer" or "multichoice"
      if (!item.containsKey('category')) {
        return {
          'message': 'Item at index $i does not contain a "category" key.',
          'success': false
        };
      }

      var category = item['category'];
      if (category != 'shortTextAnswer' && category != 'multichoice') {
        return {
          'message':
              'Item at index $i has an invalid "category" value: $category.',
          'success': false
        };
      }
    }

    List<Question> questiondata = returnQuestionData(inputData);
    state = [...questiondata];
    for (var element in state) {
      if (kDebugMode) {
        print(element.question);
      }
    }
    // All checks passed, input data is valid
    return {'message': 'Success', 'success': true};
  }

  void remove(int index) {
    final detailsListValue = state;
    detailsListValue.removeAt(index);
    state = [...detailsListValue];
  }

  int get getListLength => state.length;
}

List<Question> returnQuestionData(List<dynamic> inputData) {
  final List<Question> questiondata = inputData
      .map((e) => e['category'] == "shortTextAnswer"
          ? ShortAnswer(
              images: e["images"] ?? [],
              answer: e["correct_answer"].toString(),
              questions: e["question"].toString())
          : e['category'] == "multichoice"
              ? MultiChoice(
                  images: e["images"] ?? [],
                  answer: e["correct_answer"].toString(),
                  answers: List.generate(e["incorrect_answers"].length,
                      (index) => e["incorrect_answers"][index].toString()),
                  question_: e["question"].toString())
              : DragAndDrop(
                  correctanswers: List.generate(e["correct_answers"].length,
                      (index) => e["correct_answers"][index]),
                  incorrectanswers: List.generate(e["wrong_answer_list"].length,
                      (index) => e["wrong_answer_list"][index]),
                  questions: e["question"].toString()))
      .toList();
  return questiondata;
}
