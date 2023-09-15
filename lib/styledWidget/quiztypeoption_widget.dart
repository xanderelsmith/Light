import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/services/styles.dart';
import 'package:light/utils/quiztypechecker.dart';
import 'package:light/views/subviews/edit_quiz_screen.dart';

class QuizTypeSelectTile extends StatelessWidget {
  const QuizTypeSelectTile({
    super.key,
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).canvasColor.withOpacity(0.5),
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              3,
              (index) => GestureDetector(
                    onTap: () {
                      ref.watch(quizTypeProvider.notifier).state =
                          quizTypeChecker(index);
                    },
                    child: Card(
                        color: ref.watch(quizTypeProvider) ==
                                quizTypeChecker(index)
                            ? Styles.primaryThemeColor
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(index == 0
                              ? 'MultiChoice'
                              : index == 1
                                  ? 'shortTextAnswer'
                                  : 'Drag and Drop'),
                        )),
                  )),
        ),
      ),
    );
  }
}
