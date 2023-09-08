import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:light/models/question.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../providers/courses.dart';

class QuizController extends ChangeNotifier {
  List<Question> get questions => [];

  UnmodifiableListView<Question> get _items => UnmodifiableListView(questions);

  int get totalPrice => questions.length * 42;
  void fetchCourses() async {
    List<ParseObject> data = await Courses.pullAllCourses();
    print(data);
    List<Question> questions = data
        .map((e) => Question(
            option: e['options'] ?? [],
            question: e['question'],
            correctanswer: e['correct_answer']))
        .toList();
    addQuiz(questions);
    notifyListeners();
  }

  void fetchQuizes() {}
  void addQuiz(List<Question> questions) {
    questions.addAll(_items);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void deleteQuizData() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
