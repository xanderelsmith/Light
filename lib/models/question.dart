import 'package:flutter/material.dart';
import 'package:light/enums/quiztype_enum.dart';

class Question {
  final QuizType? quizType;

  final String question;
  final List options;
  final dynamic correctanswer;
  const Question(
      {this.correctanswer,
      Key? key,
      this.quizType,
      required this.question,
      required this.options});
}
