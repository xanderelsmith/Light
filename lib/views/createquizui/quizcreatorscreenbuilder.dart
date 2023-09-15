import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/enums/quiztype_enum.dart';
import 'package:light/views/createquizui/draggablequizcreator.dart';
import 'package:light/views/createquizui/multichoicequizscreen.dart';
import 'package:light/views/createquizui/short_answer_quiz_creator.dart';

class QuizCreatorBuilderScreen extends ConsumerWidget {
  final QuizType value;

  const QuizCreatorBuilderScreen(
      {required this.value, bool? dataisbeingEdited, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return value == QuizType.multichoice
        ? const MultiChoiceCreator()
        : value == QuizType.shortTextAnswer
            ? const ShortTextAnswerQuizCreator()
            : const DragAndDropCreator();
  }
}
