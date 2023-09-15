import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/services/styles.dart';
import 'package:light/enums/quiztype_enum.dart';
import 'package:light/views/subviews/edit_quiz_screen.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';


StateProvider<String?> facultyProvider = StateProvider<String?>((ref) {
  return null;
});
StateProvider<String?> genreProvider = StateProvider<String?>((ref) {
  return null;
});

StateProvider<String?> readmodeProvider = StateProvider<String?>((ref) {
  return null;
});

StateProvider<int?> timerNumProvider = StateProvider<int?>((ref) {
  return null;
});
final selectedlevelindexProvider = StateProvider<int>((ref) {
  return 100;
});
final modeProvider = StateProvider<String?>((ref) {
  return null;
});
var textEditingController = TextEditingController();
ScrollController scrollController = ScrollController();

class PreviewQuizScreen extends ConsumerWidget {
  const PreviewQuizScreen({Key? key, this.quizdata}) : super(key: key);
  final ParseObject? quizdata;
  static String id = 'previewQuizScreen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    Size screensize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          title: Text(
              'You added ${ref.watch(createdQuizlistdataProvider).length} quizes')),
      body: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(
            child: Scrollbar(
          controller: scrollController,
          trackVisibility: true,
          interactive: true,
          thumbVisibility: true,
          child: SingleChildScrollView(
              controller: scrollController,
              child: SizedBox(
                width: screensize.width,
                child: Column(
                  children: List.generate(
                      ref.watch(createdQuizlistdataProvider).length,
                      (index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 8),
                            child: SizedBox(
                              height: screensize.width / 1.1,
                              width: screensize.width / 1.3,
                              child: Card(
                                color: Colors.grey,
                                child: Column(children: [
                                  ListTile(
                                      leading: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: ref
                                                      .watch(createdQuizlistdataProvider)[
                                                          index]
                                                      .quizType ==
                                                  QuizType.multichoice
                                              ? const Icon(Icons.book)
                                              : ref
                                                          .watch(createdQuizlistdataProvider)[
                                                              index]
                                                          .quizType ==
                                                      QuizType.shortTextAnswer
                                                  ? const Icon(
                                                      Icons.dns_outlined)
                                                  : const Icon(Icons.padding)),
                                      contentPadding: EdgeInsets.zero,
                                      trailing: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          shape: const CircleBorder(),
                                        ),
                                        onPressed: () {
                                          ref
                                              .watch(createdQuizlistdataProvider
                                                  .notifier)
                                              .remove(index);
                                        },
                                        child: const ClipOval(
                                          child: Icon(Icons.close),
                                        ),
                                      ),
                                      title: Text(
                                        'Question ${index + 1}',
                                        style: Styles.specialTextStyle,
                                        textAlign: TextAlign.center,
                                      )),
                                  Expanded(
                                      child: Stack(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              //   gradient: monitorColor(
                                              //     index: index,
                                              //     dataList: ref.watch(
                                              //         createdQuizlistdataProvider)),
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                      top: Radius.circular(8))),
                                          width: double.infinity,
                                          child: Center(
                                              child: ref.watch(
                                                      createdQuizlistdataProvider)[
                                                  index])),
                                    ],
                                  ))
                                ]),
                              ),
                            ),
                          )),
                ),
              )),
        )),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: ElevatedButton(
              onPressed: () {
                if (ref.watch(createdQuizlistdataProvider).isEmpty) {
                  //   CustomWidgets.styledSnackBar(
                  //       context: context, message: 'You need to add quizes');
                  // } else {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => SubmitMaterialsScreen(
                  //                 quizdata: quizdata,
                  //                 userDetails: userDetails,
                  //                 isSlide: false,
                  //               )));
                }
              },
              child: Text(
                'Submit',
                style: Styles.text,
              )),
        )
      ])),
    );
  }
}
