import 'dart:collection';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:light/models/question.dart';
import 'package:provider/provider.dart';

class QuizRepoNotifier extends ChangeNotifier {
  List<Question> getQuizes = <Question>[];

  List<Question> getItems() => UnmodifiableListView(getQuizes);
  List<Question> getSize() => getQuizes;

  void add(Question value) {
    getQuizes.add(value);

    notifyListeners();
  }

  void delete(int index) {
    getQuizes.removeAt(index);

    notifyListeners();
  }

  void modify(int index, Question data) {
    getQuizes[index] = data;
    notifyListeners();
  }

  ///this stores the data of a single quiz,*(not list of quiz)
  inputData(List questionData) {
    List<Question> questiondata = questionData.map((e) {
      log(e['options'].toString());
      return Question(
          question: e['question'],
          correctanswer: e['correct_answer'],
          options: e['options']);
    }).toList();
    getQuizes = questiondata;
  }

  ///checks the quiz json data and converts them to questions class
}
