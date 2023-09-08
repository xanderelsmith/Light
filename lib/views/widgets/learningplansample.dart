import 'package:flutter/material.dart';
import 'package:light/models/question.dart';
import 'package:light/repository/retrievedQuizRepository.dart';
import 'package:light/utils/constants.dart';
import 'package:light/views/screens/quizscreen/multichoicequizscreen.dart';
import 'package:light/views/widgets/custom_quiztile.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:provider/provider.dart';

class LearningPlanSampleQuizDisplay extends StatelessWidget {
  const LearningPlanSampleQuizDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final quizlist = Provider.of<List<ParseObject>>(context);

    final quizdata = Provider.of<QuizRepoNotifier>(context);
    return ListView.builder(
        itemCount: quizlist.length,
        itemBuilder: (context, index) {
          return InkWell(
            enableFeedback: true,
            onTap: () {
              var pageController = PageController();

              quizdata.inputData(quizlist[index]['quizes']);
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  print(quizlist[index]['quizes']);
                  List quizlist2 = quizlist[index]['quizes'];
                  return MultiChoiceQuizScreen(
                      pageController: pageController,
                      quizname: quizlist[index]['question']);
                },
              ));
            },
            child: CustomQuizTile(
              title: quizlist[index]['question'],
            ),
          );
        });
  }
}
