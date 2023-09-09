// ignore_for_file: unnecessary_brace_in_string_interps
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spark_ai/models/quiz_details.dart';
import 'package:spark_ai/utilities/providers.dart';
import '../../repositories/quiz/retrieved_quizdata_repository.dart';
import '../../utilities/quiz_image_viewer.dart';
import '../../utilities/styles.dart';
import '../../screens/quizscreens/multichoicequizscreen.dart';
import '../resultscreen/resultscreen.dart';

class MainQuizScreen extends HookConsumerWidget {
  static String id = 'MainQuizScreen';
  const MainQuizScreen(
      {this.topicname,
      this.quizDetails,
      this.coursename,
      this.coursecode,
      Key? key})
      : super(key: key);
  final String? coursecode;
  final String? coursename;
  final String? topicname;
  final QuizDetails? quizDetails;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    final quizlist = ref.watch(quizListProvider).getQuizes;
    final quizdatacontroller = ref.watch(quizcontrollerProvider);
    Size screensize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return Future.delayed(const Duration(milliseconds: 500), () {
          ref.refresh(quizcontrollerProvider);
          Navigator.pop(context);
          return true;
        });
      },
      child: PageView.builder(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: quizlist.length,
          itemBuilder: (context, index) => Scaffold(
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: quizlist[index],
                ),
                bottomSheet: Container(
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)),
                    color: Colors.grey,
                  ),
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(left: 30.0, top: 10),
                  child: quizdatacontroller.answered
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              quizlist[index].correctanswer is List
                                  ? quizlist[index].question
                                  : 'Answer:\t${quizlist[index].correctanswer}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            quizlist[index].hintimages!.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => QuizImageViewer(
                                            images: quizlist[index].hintimages),
                                      );
                                    },
                                    icon: Icon(Icons.image))
                                : SizedBox.shrink()
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
                bottomNavigationBar: Builder(
                  builder: (context) {
                    return quizdatacontroller.answered
                        ? Container(
                            height: 100,
                            color: pageController.page!.toInt() + 1 <
                                    quizlist.length
                                ? Colors.grey
                                : null,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomButton(
                                title: pageController.page!.toInt() + 1 <
                                        quizlist.length
                                    ? 'Next Question'
                                    : 'See Results',
                                onTap: () {
                                  if (pageController.page!.toInt() + 1 <
                                      quizlist.length) {
                                    ref
                                        .watch(quizcontrollerProvider.notifier)
                                        .nextQuestion(quizlist,
                                            pageController.page!.toInt());

                                    if (pageController.page!.toInt() + 1 <
                                        quizlist.length) {
                                      pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 250),
                                        curve: Curves.linear,
                                      );
                                    }
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                QuizResultScreen(
                                                    quizDetails:
                                                        quizDetails))));
                                  }
                                },
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                  },
                ),
                appBar: PreferredSize(
                  preferredSize: Size(screensize.width, 180),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15.0, 55, 15, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  '${coursecode}\n${coursename}\n\n${topicname}'),
                              CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  child: ClipOval(
                                    child: ref
                                                .watch(userDetaisStateProvider)
                                                .getUserdetails!
                                                .user['gender'] ==
                                            'Guy'
                                        ? Image.asset('images/boyavatar.png')
                                        : Image.asset('images/girlavatar.png'),
                                  )),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                              text: 'Question ${index + 1}',
                              style: Styles.titleTextStyle.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '/${quizlist.length}',
                                    style: Styles.titleTextStyle.copyWith(
                                        fontSize: 20, color: Colors.grey))
                              ]),
                        ),
                        Wrap(
                            children: List.generate(
                                quizlist.length,
                                (indicatorindex) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 3, vertical: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: indicatorindex == index
                                            ? Styles.primaryThemeColor
                                            : Colors.grey,
                                      ),
                                      width: 15,
                                      height: 4,
                                    ))),
                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}

final List<BoxShadow> boxShadow = [
  const BoxShadow(
    color: Colors.black26,
    offset: Offset(0, 2),
    blurRadius: 4.0,
  ),
];

class CustomButton extends StatelessWidget {
  final String title;
  final Function onTap;

  const CustomButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.all(20.0),
        height: 50.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.yellow[700],
          boxShadow: boxShadow,
          borderRadius: BorderRadius.circular(25.0),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
