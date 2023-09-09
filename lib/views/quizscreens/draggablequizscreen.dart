//documentation: it uses a list of question words, which are loaded into another list ,if the correct answer is containing the word(question word)then store that index as "", basically on drag,it updates that index,

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spark_ai/screens/quizscreens/mainquizscreen.dart';
import 'package:spark_ai/screens/quizscreens/multichoicequizscreen.dart';
import 'package:spark_ai/screens/creatematerials_ui/quizmodels/created_quiz_viewer_ui/question_model.dart';
import 'package:spark_ai/utilities/styles.dart';
import '../../enums/quiztype_enum.dart';
import '../creatematerials_ui/quizmodels/created_quiz_viewer_ui/dragandropquizviewer.dart';

bool hintishidden = true;

class DraggableQuizScreen extends Question {
  final int? indexD;
  @override
  // TODO: implement index
  int? get index => indexD;
  @override
  QuizType? get quizType => QuizType.draganddrop;
  final String questions;
  @override
  get question => questions;

  @override
  List<String> get correctanswer => correctanswers!;
  final List<String>? correctanswers;
  final List<String> incorrectanswers;
  const DraggableQuizScreen({
    Key? key,
    required this.correctanswers,
    this.indexD,
    required this.incorrectanswers,
    required this.questions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> selectedAnswers = [];
    Size screensize = MediaQuery.of(context).size;

    List allanswers = [...incorrectanswers, ...correctanswer];
    return DraggableQuizBody(
        index: indexD,
        incorrectanswers: incorrectanswers,
        question: questions,
        ref: ref,
        correctanswers: correctanswers,
        selectedAnswers: selectedAnswers,
        screensize: screensize,
        allanswers: allanswers.map((e) => e.toString()).toList());
  }

  @override
  Map toJson() {
    return {};
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [correctanswers, incorrectanswers, questions, quizType];

  @override
  // TODO: implement stringify
  bool? get stringify => true;
}

class DraggableQuizBody extends ConsumerStatefulWidget {
  const DraggableQuizBody({
    this.index,
    Key? key,
    required this.correctanswers,
    required this.incorrectanswers,
    required this.selectedAnswers,
    required this.screensize,
    required this.allanswers,
    required this.ref,
    required this.question,
  }) : super(key: key);
  final WidgetRef ref;
  final int? index;
  final List<String>? correctanswers;
  final List<String>? incorrectanswers;
  final List<String> selectedAnswers;
  final Size screensize;
  final List<String> allanswers;
  final String question;

  @override
  ConsumerState<DraggableQuizBody> createState() =>
      _DraggableQuizBodyConsumerState();
}

class _DraggableQuizBodyConsumerState extends ConsumerState<DraggableQuizBody> {
  List questionwordsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var splitedquestion = widget.question.split(' ');
    questionwordsList = List.generate(
        splitedquestion.length,
        (index) => !widget.correctanswers!
                .any((element) => splitedquestion[index] == element)
            ? widget.question.split(' ')[index]
            : '');
  }

  @override
  Widget build(BuildContext context) {
    final quizdatacontroller = ref.watch(quizcontrollerProvider);
    if (kDebugMode) {
      print(widget.selectedAnswers);
    }
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 3),
                        child: Text(
                          'Hint',
                          style: TextStyle(
                            color: Styles.primaryThemeColor,
                          ),
                        )),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: List.generate(
                          questionwordsList.length,
                          (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: widget.allanswers.any((element) =>
                                                    questionwordsList[index] ==
                                                    element) ==
                                                true ||
                                            questionwordsList[index] == ''
                                        ? DragTarget<String>(
                                            onMove: (data) {},
                                            onLeave: (data) {},
                                            onAccept: (data) => {
                                              if (questionwordsList[index] ==
                                                  '')
                                                {
                                                  setState(() {
                                                    if (widget.selectedAnswers
                                                            .length <=
                                                        widget.correctanswers!
                                                            .length) {
                                                      questionwordsList
                                                        ..removeAt(index)
                                                        ..insert(index,
                                                            data); //addd them to selected answers list
                                                      widget.selectedAnswers
                                                          .add(data);
                                                    }
                                                  })
                                                }
                                            },
                                            onWillAccept: (data) {
                                              return true;
                                            },
                                            builder: (BuildContext context,
                                                    List<Object?> candidateData,
                                                    List<dynamic>
                                                        rejectedData) =>
                                                Card(
                                                    color: quizdatacontroller
                                                                .answered ==
                                                            true
                                                        ? widget.correctanswers!
                                                                    .contains(
                                                                  questionwordsList[
                                                                      index],
                                                                ) &&
                                                                !widget
                                                                    .incorrectanswers!
                                                                    .contains(
                                                                  questionwordsList[
                                                                      index],
                                                                )
                                                            ? Colors.green
                                                            : Colors.red
                                                        : Theme.of(context)
                                                            .canvasColor
                                                            .withOpacity(0.3),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        {
                                                          //remove them to selected answers list
                                                          widget.selectedAnswers
                                                              .remove(
                                                                  questionwordsList[
                                                                      index]);
                                                          setState(() {
                                                            questionwordsList
                                                              ..removeAt(index)
                                                              ..insert(
                                                                  index, '');
                                                          });
                                                        }
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 8.0,
                                                                horizontal: 25),
                                                        child: Text(
                                                          questionwordsList[
                                                              index],
                                                          style: Styles.text
                                                              .copyWith(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText2!
                                                                      .color),
                                                        ),
                                                      ),
                                                    )),
                                          )
                                        : Text(questionwordsList[index],
                                            style: Styles.text)),
                              )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: widget.screensize.width,
            height: widget.screensize.width - 150,
            child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                children: List.generate(
                  widget.allanswers.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Draggable<String>(
                        data: widget.allanswers[index],
                        childWhenDragging: const SizedBox(),
                        feedback: Material(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(widget.allanswers[index],
                                  style: Styles.text.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color))),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: widget.selectedAnswers
                                      .contains(widget.allanswers[index])
                                  ? Theme.of(context)
                                      .canvasColor
                                      .withOpacity(0.1)
                                  : quizdatacontroller.answered == true &&
                                          widget.correctanswers!.contains(
                                                widget.allanswers[index],
                                              ) ==
                                              true
                                      ? Colors.green
                                      : Theme.of(context).canvasColor),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Text(
                                widget.selectedAnswers
                                        .contains(widget.allanswers[index])
                                    ? ''
                                    : widget.allanswers[index],
                                style: Styles.text.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .color)),
                          ),
                        ),
                      ),
                    );
                  },
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 28, 0, 8),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10))),
              width: double.maxFinite,
              child: ref.watch(quizcontrollerProvider).answered == false
                  ? CustomButton(
                      onTap: () {
                        ref.watch(quizcontrollerProvider.notifier).submitAnswer(
                            DragAndDrop(
                                indexD: widget.index,
                                correctanswers: widget.correctanswers,
                                incorrectanswers: widget.incorrectanswers!,
                                questions: widget.question),
                            questionwordsList);
                      },
                      title: 'Check')
                  : const SizedBox.shrink(),
            ),
          )
        ],
      ),
    );
  }
}
