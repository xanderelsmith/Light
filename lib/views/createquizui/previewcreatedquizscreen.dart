import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../db_handler/styles.dart';
import '../../quizmodels/base_create_quiz_ui_data.dart';

import '../../styledWidget/specialtextfield.dart';
import 'createquizscreen.dart';

class PreviewQuizScreen extends ConsumerWidget {
  const PreviewQuizScreen({
    Key? key,
  }) : super(key: key);

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
          trackVisibility: true,
          interactive: true,
          thumbVisibility: true,
          child: SingleChildScrollView(
              child: SizedBox(
            width: screensize.width,
            child: Column(
              children: List.generate(
                  ref.watch(createdQuizlistdataProvider).length,
                  (index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 8),
                        child: SizedBox(
                          height: screensize.width / 1.129,
                          width: screensize.width / 1.3,
                          child: Card(
                            color: Colors.grey,
                            child: Column(children: [
                              ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  trailing: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      shape: const CircleBorder(),
                                    ),
                                    onPressed: () {
                                      ref
                                          .watch(createdQuizlistdataProvider
                                              .notifier)
                                          .remove(index);
                                    },
                                    child: const ClipOval(
                                      child: const Icon(Icons.close),
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
                showModalBottomSheet(
                    enableDrag: true,
                    context: context,
                    builder: (context) => BottomSheet(
                          onDragStart: (details) {},
                          enableDrag: true,
                          backgroundColor:
                              MediaQuery.of(context).platformBrightness !=
                                      Brightness.dark
                                  ? const Color(0xff707070)
                                  : const Color(0xff0b0e11),
                          builder: (context) => Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10)),
                              color: Theme.of(context).canvasColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Center(
                                      child: Text('Fill the required details')),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0),
                                    child: const SpecialTextfield(
                                        innerHint: 'Engineering Workshop',
                                        textCapitalization:
                                            TextCapitalization.words,
                                        textfieldname: 'Course Name'),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0),
                                    child: SpecialTextfield(
                                        textfieldname: 'Course Code',
                                        textCapitalization:
                                            TextCapitalization.characters,
                                        innerHint: 'e.g ENG 102'),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: List.generate(
                                      2,
                                      (index) => Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              index == 0 ? 'Genre' : 'Mode',
                                              textAlign: TextAlign.center,
                                            ),
                                            DropdownButton<String>(
                                                hint: Icon(Icons
                                                    .library_books_outlined),
                                                iconEnabledColor:
                                                    Styles.primaryThemeColor,
                                                elevation: 100,
                                                value: 'science',
                                                items: List.generate(
                                                  2,
                                                  (index) =>
                                                      DropdownMenuItem<String>(
                                                    value: index == 0
                                                        ? 'engineering'
                                                        : index == 1
                                                            ? 'science'
                                                            : 'Business',
                                                    child: FittedBox(
                                                        child: Text(index == 0
                                                            ? 'Exam'
                                                            : 'Practice')),
                                                  ),
                                                ),
                                                onChanged: (value) {}),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                    child: ListView.builder(
                                        controller: ScrollController(
                                            initialScrollOffset: 50),
                                        itemCount: 7,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) => Card(
                                              margin: const EdgeInsets.all(8.0),
                                              color: Colors.red,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  width: 80,
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          '${index + 1}00',
                                                          style: Styles
                                                              .specialTextStyle,
                                                        )
                                                      ]),
                                                ),
                                              ),
                                            )),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'institution',
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: DropdownButton<String>(
                                            hint: Icon(
                                                Icons.library_books_outlined),
                                            iconEnabledColor:
                                                Styles.primaryThemeColor,
                                            elevation: 100,
                                            value: 'science',
                                            items: List.generate(
                                              3,
                                              (index) =>
                                                  DropdownMenuItem<String>(
                                                value: index == 0
                                                    ? 'engineering'
                                                    : index == 1
                                                        ? 'science'
                                                        : 'Business',
                                                child: FittedBox(
                                                    child: Text(index == 0
                                                        ? 'Exam'
                                                        : 'Practice')),
                                              ),
                                            ),
                                            onChanged: (value) {}),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                      onPressed: () {},
                                      child: const Text('Submit'))
                                ],
                              ),
                            ),
                          ),
                          onClosing: () {},
                        ));
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
