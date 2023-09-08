import 'package:flutter/material.dart';
import 'package:light/models/question.dart';
import 'package:light/repository/retrievedQuizRepository.dart';
import 'package:light/utils/constants.dart';
import 'package:light/views/screens/quizscreen/multichoicequizscreen.dart';
import 'package:light/views/widgets/custom_quiztile.dart';
import 'package:light/views/widgets/optionstile.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:provider/provider.dart';

class QuizList extends StatelessWidget {
  const QuizList({super.key});

  @override
  Widget build(BuildContext context) {
    final quizdata = Provider.of<QuizRepoNotifier>(context);
    final quizlist = Provider.of<List<ParseObject>>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Quizes',
                      style: Constants.kminTextStyle.copyWith(fontSize: 20)),
                  CircleAvatar(
                    child: Icon(
                      Icons.person,
                      color: Colors.blue.withOpacity(0.1),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  height: 50,
                  width: double.maxFinite,
                  child: Card(
                    color: Colors.blue.withOpacity(0.1),
                    elevation: 0,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                          decoration: InputDecoration(
                              icon: Icon(Icons.search),
                              hintText: 'Find Course')),
                    ),
                  ),
                ),
              ),
              SizedBox(
                  width: double.maxFinite,
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return OptionTile(
                        info: optionTileData[index].info,
                        imageloc: optionTileData[index].imageLoc,
                        colorInfo: optionTileData[index].color!,
                      );
                    },
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: Text('Take a quiz',
                    style: Constants.kminTextStyle.copyWith(
                      fontSize: 15,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ChoiceChip(
                                label: Text(index == 0
                                    ? 'All'
                                    : index == 1
                                        ? 'Popular'
                                        : 'New'),
                                selected: true,
                              ),
                            ))),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: quizlist.length,
                      itemBuilder: (context, index) => InkWell(
                            enableFeedback: true,
                            onTap: () {
                              List quizlist2 = quizlist[index]['quizes'];
                              var pageController = PageController();
                              quizdata.inputData(quizlist2);
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  print(quizlist[index]['quizes']);
                                  return MultiChoiceQuizScreen(
                                    pageController: pageController,
                                    quizname: quizlist[index]['question'],
                                  );
                                },
                              ));
                            },
                            child: CustomQuizTile(
                              title: quizlist[index]['question'],
                            ),
                          )))
            ],
          ),
        ),
      ),
    );
  }
}
