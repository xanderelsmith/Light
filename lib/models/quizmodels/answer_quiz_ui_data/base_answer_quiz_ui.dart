import 'package:flutter/material.dart';
import 'package:light/enums/quiztype_enum.dart';

///abstract class that contains what quiz ui basic data for answering data
abstract class QuizScreenFormat extends StatelessWidget {
  final QuizType? quizType;

  final dynamic question;
  const QuizScreenFormat({
    Key? key,
    this.quizType,
    this.question,
  }) : super(key: key);

  ///returns a build ui for the quiz
  @override
  Widget build(BuildContext context);
}
