import 'package:flutter/material.dart';
import '../enums/quiztype_enum.dart';

abstract class QuizViewFormat extends StatelessWidget {
  final QuizType? quizType;
  final dynamic question;
  const QuizViewFormat({Key? key, this.quizType, this.question})
      : super(key: key);

  @override
  Widget build(BuildContext context);
}
