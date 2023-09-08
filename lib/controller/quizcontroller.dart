import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:light/models/question.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../providers/courses.dart';

class QuizController extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Question> _items = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Question> get questions => UnmodifiableListView(_items);

  int get totalPrice => questions.length * 42;
  Future<bool> fetchCourses() async {
    List<ParseObject> data = await Courses.pullAllCourses();

    List<Question> questions = data
        .map((e) => Question(
            question: e['question'], correctanswer: e['correctanswer']))
        .toList();
    addQuiz(questions);
    notifyListeners();
    return data.isNotEmpty ? false : true;
  }

  void fetchQuizes() {}
  void addQuiz(List<Question> questions) {
    _items.addAll(questions);
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
