import 'package:flutter/material.dart';
import 'package:light/enums/quiztype_enum.dart';
 class Question  {
  final QuizType? quizType;

  final dynamic question;
  final dynamic correctanswer;
  const Question({
    this.correctanswer,
    Key? key,
    this.quizType,
    this.question,
  });

}
