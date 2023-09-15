import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/controller/draggablequiz_controller.dart';
import 'package:light/models/quizmodels/created_quiz_viewer_ui/dragandropquizviewer.dart';
import 'package:light/services/styles.dart';
import 'package:light/styledWidget/specialtextfield.dart';
import 'package:light/views/subviews/edit_quiz_screen.dart';
import 'package:light/views/widgets/custom.dart';
import 'package:light/views/widgets/draggable_options_card.dart';
import 'short_answer_quiz_creator.dart';

//a textediting controller provider  for updating the questions
final draggableQuestionControllerProvider =
    StateProvider<TextEditingController>((ref) {
  return TextEditingController(text: 'Science is the ethos of all');
});

final questionListProvider = StateNotifierProvider<
    DraggableQuestionListValueClass,
    DraggableQuestionDetails>((ref) => DraggableQuestionListValueClass());

//list of booleans to check which value is being edited

class DragAndDropCreator extends ConsumerWidget {
  const DragAndDropCreator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size screenSize = MediaQuery.of(context).size;
    final questionsWatcher = ref.watch(questionListProvider.notifier);
    final questionListWatcher = ref.watch(createdQuizlistdataProvider.notifier);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: screenSize.width,
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      TextButton(
                        //TODO:add a picture illustrating the hnt below
                        child: const Text('Hint', textAlign: TextAlign.end),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('ok'))
                                    ],
                                    title: const Text('Notice'),
                                    content: const Text(
                                        'It is advisable to add at most, two answers from the question'),
                                  ));
                        },
                      ),
                    ]),
                    ref.watch(isEditedStateProvider) == false
                        ? SpecialTextfield(
                            textfieldname: 'Input full sentence',
                            controller:
                                ref.watch(draggableQuestionControllerProvider),
                            textInputtype: TextInputType.multiline,
                          )
                        : SizedBox(
                            width: screenSize.width,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18.0, horizontal: 10),
                              child: Wrap(
                                children: List.generate(
                                    questionsWatcher.questionlistValue!.length,
                                    (index) => GestureDetector(
                                          onTap: () {
                                            ref.watch(questionListProvider);
                                            if (questionsWatcher
                                                    .questionAnswer!.length <
                                                5) {
                                              questionsWatcher.updateAnswers(
                                                  DraggableAnswerDetails(
                                                      answer: questionsWatcher
                                                              .questionlistValue![
                                                          index],
                                                      isEdited: false));
                                            }
                                            if (questionsWatcher
                                                    .questionAnswer!.length ==
                                                5) {
                                              styledSnackBar(
                                                  context: context,
                                                  message:
                                                      'Answer List limit(5) reached');
                                            }
                                          },
                                          child: Card(
                                              color: ref
                                                      .watch(
                                                          questionListProvider
                                                              .notifier)
                                                      .questionAnswer!
                                                      //"any" method for panning through list based on your condition
                                                      .any((element) =>
                                                          element.answer ==
                                                          questionsWatcher
                                                                  .questionlistValue![
                                                              index])
                                                  ? Styles.primaryThemeColor
                                                  : Theme.of(context)
                                                      .canvasColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 3),
                                                child: Text(
                                                  questionsWatcher
                                                          .questionlistValue![
                                                      index],
                                                  style: Styles.text,
                                                ),
                                              )),
                                        )),
                              ),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ElevatedButton(
                        child: Text(ref.watch(isEditedStateProvider) == false
                            ? 'Decode'
                            : 'Edit'),
                        onPressed: () {
                          ref.watch(isEditedStateProvider.notifier).state =
                              ref.watch(isEditedStateProvider) == false
                                  ? true
                                  : false;

                          questionsWatcher.updateQuestions(ref
                              .watch(draggableQuestionControllerProvider)
                              .text
                              .split(" "));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                if (questionsWatcher.questionAnswer!.length < 5) {
                  ref.watch(questionListProvider);
                  questionsWatcher.addDummyData(
                      DraggableAnswerDetails(answer: 'value', isEdited: false));
                } else {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Answer list limit reached'),
                  ));
                }
              },
              child: const Text('Add an option')),
          SizedBox(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: List.generate(questionsWatcher.questionAnswer!.length,
                  (index) {
                var answerDetails = ref
                    .watch(questionListProvider.notifier)
                    .questionAnswer![index];
                return DraggableOptionCard(
                  onEditingChange: (value) {
                    answerDetails.answer = value;
                  },
                  isEditing: questionsWatcher.questionAnswer![index].isEdited!,
                  screenSize: screenSize,
                  questionsWatcher: questionsWatcher,
                  ref: ref,
                  index: index,
                  onEditedClick: () {
                    //watching and updating edit option state
                    ref.watch(questionListProvider);
                    ref
                        .watch(questionListProvider.notifier)
                        .updateAnAnswerValue(
                            value: answerDetails, index: index);
                    ref
                        .watch(questionListProvider.notifier)
                        .updateboolValue(index);
                  },
                );
              }),
            ),
          )),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: ElevatedButton(
                onPressed: () {
                  if (questionsWatcher.questionAnswer!.isNotEmpty &&
                      ref
                          .watch(questionListProvider.notifier)
                          .questionlistValue!
                          .isNotEmpty) {
                    ref.watch(createdQuizlistdataProvider);
                    questionListWatcher.addQuiz(DragAndDrop(
                        correctanswers: [
                          //answers are in the question
                          for (var element in questionsWatcher.questionAnswer!)
                            if (ref
                                    .watch(questionListProvider.notifier)
                                    .questionlistValue!
                                    .contains(element.answer) ==
                                true)
                              element.answer!
                        ],
                        incorrectanswers: [
                          // question doesnt contains answer
                          for (var element in questionsWatcher.questionAnswer!)
                            if (ref
                                    .watch(questionListProvider.notifier)
                                    .questionlistValue!
                                    .contains(element.answer) ==
                                false)
                              element.answer!
                        ],
                        questions: ref
                            .watch(draggableQuestionControllerProvider)
                            .text
                            .trim()));
                    questionsWatcher.questionAnswer!.clear();
                    ref
                        .watch(draggableQuestionControllerProvider.notifier)
                        .state
                        .clear();
                  } else {
                    styledSnackBar(
                        context: context,
                        message: 'input fields must not be empty');
                  }
                },
                style: chipStyleButton,
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
