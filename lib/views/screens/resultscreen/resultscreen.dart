import 'package:flutter/material.dart';
import 'package:light/models/quiz_details.dart';
import 'package:light/repository/quizcontroller.dart';
import 'package:light/repository/retrievedQuizRepository.dart';
import 'package:light/utils/constants.dart';
import 'package:light/views/screens/quizscreen/multichoicequizscreen.dart';
import 'package:provider/provider.dart';

class QuizResultScreen extends StatefulWidget {
  static String id = 'QuizResultScreen';
  const QuizResultScreen({
    this.quizDetails,
    Key? key,
  }) : super(key: key);
  final QuizDetails? quizDetails;
  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  bool isInterstitialLoaded = false;

  @override
  Widget build(BuildContext context) {
    final quizdatacontroller = Provider.of<QuizController>(context);
    final quizdata = Provider.of<QuizRepoNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        centerTitle: true,
        title: Text(
          // !quizstate.incorrect.isNotEmpty
          //     ? 'Congratulations'
          //     :
          'Let\'s get better, Comrade!',
          textAlign: TextAlign.center,
          style: Constants.titleTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('images/trophy.png', height: 150),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Keep practicing and you\'ll never forget the answers to these questions!',
                textAlign: TextAlign.center,
                style: Constants.text,
              ),
            ),
            Text(
              'Your Score',
              style: Constants.kminTextStyle.copyWith(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            Text.rich(
              TextSpan(
                  text: '${quizdatacontroller.quizstate.correct.length}',
                  style: Constants.kminTextStyle.copyWith(
                    fontSize: 50,
                    color: Colors.blueAccent,
                  ),
                  children: [
                    TextSpan(
                      text: '/${quizdata.getQuizes.length}',
                      style: Constants.kminTextStyle.copyWith(
                        fontSize: 40,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                    ),
                  ]),
              textAlign: TextAlign.center,
            ),
            Text(
              'Rate the quiz',
              style: Constants.text,
            ),
            FloatingActionButton.extended(
              label: Text(
                'Close ',
                style: Constants.text.copyWith(fontSize: 30),
              ),
              onPressed: () {
                quizdatacontroller
                  ..clearQuizState()
                  ..reset();
                Navigator.pop(context);
                Navigator.pop(context);
                // context,
                // MaterialPageRoute(
                //     builder: ((context) => Previewfailedquestions(
                //         listdata: quizdatacontroller.incorrect))));
              },
            ),
          ],
        ),
      ),
    );
  }
}
