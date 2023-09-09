import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../enums/quiztype_enum.dart';
import '../../utilities/createquizgradients.dart';
import '../../utilities/styles.dart';

class Previewfailedquestions extends HookConsumerWidget {
  const Previewfailedquestions({Key? key, required this.listdata})
      : super(key: key);
  static String id = 'previewQuizScreen';

  final List listdata;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var scrollController = useScrollController();

    Size screensize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
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
                      listdata.length,
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
                                          child: listdata[index].quizType ==
                                                  QuizType.multichoice
                                              ? const Icon(Icons.book)
                                              : listdata[index].quizType ==
                                                      QuizType.shortTextAnswer
                                                  ? const Icon(
                                                      Icons.dns_outlined)
                                                  : const Icon(Icons.padding)),
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        'Question ${listdata[index].index + 1}',
                                        style: Styles.specialTextStyle,
                                        textAlign: TextAlign.center,
                                      )),
                                  Expanded(
                                      child: Stack(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              gradient: monitorColor(
                                                  index: index,
                                                  dataList: listdata),
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                      top: Radius.circular(8))),
                                          width: double.infinity,
                                          child:
                                              Center(child: listdata[index])),
                                    ],
                                  ))
                                ]),
                              ),
                            ),
                          )),
                ),
              )),
        )),
      ])),
    );
  }
}
