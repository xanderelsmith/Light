import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/views/createquizui/createquizscreen.dart';
import 'package:light/views/createquizui/multichoicequizviewer.dart';

import '../../db_handler/styles.dart';
import '../../styledWidget/specialtextfield.dart';

class MultiChoiceCreator extends ConsumerWidget {
  const MultiChoiceCreator({
    Key? key,
  }) : super(key: key);
  static TextEditingController correctanswerController =
      TextEditingController();
  static TextEditingController questionController = TextEditingController();
  static TextEditingController incorrect1 = TextEditingController();
  static TextEditingController incorrect2 = TextEditingController();
  static TextEditingController incorrect3 = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionListWatcher = ref.watch(createdQuizlistdataProvider.notifier);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Quiz question'),
                ),
                SpecialTextfield(
                  controller: questionController,
                  innerHint: 'e.g What is the name of your pokemon',
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                color: Theme.of(context).canvasColor),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: const Text('Quiz Answers'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SpecialTextfield(
                  controller: incorrect1,
                  textfieldname: 'Enter false Answer 1',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SpecialTextfield(
                  controller: incorrect2,
                  textfieldname: 'Enter false Answer 2',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SpecialTextfield(
                  controller: incorrect3,
                  textfieldname: 'Enter false Answer 3',
                ),
              ),
              const Text('Insert the correct answer below'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SpecialTextfield(
                  controller: correctanswerController,
                  textfieldname: 'Enter Answer ',
                ),
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: ElevatedButton(
                onPressed: () {
                  ref.watch(createdQuizlistdataProvider);
                  questionListWatcher.addQuiz(MultiChoice(
                      correctanswer: correctanswerController.text.trim(),
                      answers: [
                        incorrect1.text,
                        incorrect2.text.trim(),
                        incorrect3.text.trim()
                      ],
                      question_: questionController.text.trim()));
                },
                child: Text(
                  'Add Quiz',
                  style: Styles.text,
                )),
          )
        ],
      ),
    );
  }
}
