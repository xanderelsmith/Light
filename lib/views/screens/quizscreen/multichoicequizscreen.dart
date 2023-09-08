import 'package:flutter/material.dart';
import 'package:light/models/question.dart';
import 'package:light/models/question.dart';
import 'package:light/repository/quizcontroller.dart';
import 'package:light/repository/retrievedQuizRepository.dart';
import 'package:light/utils/constants.dart';
import 'package:light/views/screens/resultscreen/resultscreen.dart';
import 'package:provider/provider.dart';

class MultiChoiceQuizScreen extends StatefulWidget {
  @override
  const MultiChoiceQuizScreen({
    required this.quizname,
    super.key,
    required this.pageController,
  });
  final PageController pageController;

  final String quizname;

  @override
  State<MultiChoiceQuizScreen> createState() => _MultiChoiceQuizScreenState();
}

class _MultiChoiceQuizScreenState extends State<MultiChoiceQuizScreen> {
  late String? selectedanswer;
  @override
  void initState() {
    super.initState();
    // 2
  }

  @override
  void dispose() {
    // 3
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quizlist = Provider.of<QuizRepoNotifier>(context).getQuizes;
    final quizdatacontroller = Provider.of<QuizController>(context);
    final quizStateController = quizdatacontroller.quizstate;
    print(quizlist.length);
    return Scaffold(
      bottomNavigationBar:
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Quit Quiz')),
        ElevatedButton(
            onPressed: () {
              var pageNum = widget.pageController.page!.toInt();
              quizdatacontroller.nextQuestion(
                  quizlist, (widget.pageController.page! - 1).toInt());

              if (pageNum < (quizlist.length - 1)) {
                widget.pageController.jumpToPage(pageNum + 1);
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QuizResultScreen(),
                    ));
              }
            },
            child: const Text('Next')),
      ]),
      body: PageView.builder(
          controller: widget.pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: quizlist.length,
          itemBuilder: (context, index) {
            var options = quizlist[index].options;
            print(options);
            return SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 8.0),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quiz Topic:\t${widget.quizname}',
                          style: Constants.kmaxTextStyle
                              .copyWith(fontSize: 20, color: Colors.grey),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18.0),
                          child: Text(
                            'Question ${index + 1}/${quizlist.length}',
                            style:
                                Constants.kmaxTextStyle.copyWith(fontSize: 30),
                          ),
                        ),
                        Row(
                          children: List.generate(
                              quizlist.length,
                              (index) => Container(
                                    margin: const EdgeInsets.all(3),
                                    height: 3,
                                    width: 10,
                                    color: Colors.red,
                                  )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(quizlist[index].question,
                              style: Constants.titleTextStyle),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: options
                                .map(
                                  (e) => AnswerCard(
                                      answer: e,
                                      isSelected: e ==
                                          quizStateController.selectedAnswer,
                                      isCorrect:
                                          e == quizlist[index].correctanswer,
                                      isDisplayingAnswer:
                                          quizStateController.answered,
                                      onTap: () {
                                        quizdatacontroller.submitAnswer(
                                            Question(
                                                correctanswer: quizlist[index]
                                                    .correctanswer,
                                                question:
                                                    quizlist[index].question,
                                                options:
                                                    quizlist[index].options),
                                            e.toString());
                                        setState(() {});
                                      }),
                                )
                                .toList(),
                          ),
                        ),
                      ]),
                ),
              ),
            );
          }),
    );
  }
}

//
class AnswerCard extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final bool isCorrect;
  final bool isDisplayingAnswer;
  final VoidCallback onTap;

  const AnswerCard({
    Key? key,
    required this.answer,
    required this.isSelected,
    required this.isCorrect,
    required this.isDisplayingAnswer,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 20.0,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 20.0,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isDisplayingAnswer
                ? isCorrect
                    ? Colors.green
                    : isSelected
                        ? Colors.red
                        : Colors.white
                : Colors.white,
            width: 4.0,
          ),
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                answer,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: isDisplayingAnswer && isCorrect
                      ? FontWeight.bold
                      : FontWeight.w400,
                ),
              ),
            ),
            if (isDisplayingAnswer)
              isCorrect
                  ? const CircularIcon(icon: Icons.check, color: Colors.green)
                  : isSelected
                      ? const CircularIcon(
                          icon: Icons.close,
                          color: Colors.red,
                        )
                      : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

//
class CircularIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const CircularIcon({
    Key? key,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.0,
      width: 24.0,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 16.0,
      ),
    );
  }
}
