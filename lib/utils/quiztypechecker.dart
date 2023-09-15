import 'package:light/enums/quiztype_enum.dart';

QuizType quizTypeChecker(index) {
  return index == 0
      ? QuizType.multichoice
      : index == 1
          ? QuizType.shortTextAnswer
          : QuizType.draganddrop;
}
