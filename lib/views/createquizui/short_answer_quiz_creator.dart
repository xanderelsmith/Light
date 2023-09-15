import 'package:flutter/material.dart';
import 'package:light/models/quizmodels/created_quiz_viewer_ui/shortanswerquizviewer.dart';
import 'package:light/services/styles.dart';
import 'package:light/styledWidget/specialtextfield.dart';
import 'package:light/views/subviews/edit_quiz_screen.dart';
import 'package:light/views/widgets/postimageview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


StateProvider<bool> isEditedStateProvider = StateProvider<bool>((ref) {
  return true;
});

class ShortTextAnswerQuizCreator extends ConsumerStatefulWidget {
  const ShortTextAnswerQuizCreator({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ShortTextAnswerQuizCreatorState();
}

class _ShortTextAnswerQuizCreatorState
    extends ConsumerState<ShortTextAnswerQuizCreator> {
  final suggestedTags = [
    "Phy Sci",
    "Comp Sci",
    "Engr",
    "Life Sci",
  ];
List images = [];
  Set<String> tagList = {};
  // late ImagePicker imagePicker;
  // List<XFile> images = [];
  late TextEditingController postTextController;
  late TextEditingController tagTextController;
  late TextEditingController titleTextController;
  static TextEditingController answerController = TextEditingController();
  static TextEditingController questionController = TextEditingController();
  @override
  void initState() {
    // imagePicker = ImagePicker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final questionListWatcher = ref.watch(createdQuizlistdataProvider.notifier);
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
              height: screenSize.height / 3,
              width: screenSize.width,
              child: Card(
                  child: Stack(
                children: [
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ref.watch(isEditedStateProvider) == false
                        ? SpecialTextfield(
                            controller: questionController,
                            innerHint: 'Input question',
                            textInputtype: TextInputType.multiline)
                        : Text(
                            questionController.text.isEmpty
                                ? 'No input!'
                                : questionController.text,
                            textAlign: TextAlign.center,
                            style: Styles.titleTextStyle),
                  )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(150, 30)),
                          onPressed: () {
                            ref.watch(isEditedStateProvider.notifier).state =
                                ref.watch(isEditedStateProvider) == false
                                    ? true
                                    : false;
                          },
                          child: Text(
                            ref.watch(isEditedStateProvider.notifier).state ==
                                    false
                                ? 'Set'
                                : 'Edit',
                          )),
                    ),
                  )
                ],
              ))),
          SizedBox(height: screenSize.height * 0.12),
          SizedBox(
            height: 100,
            width: screenSize.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                            images.isEmpty ? 1 : images.length,
                            (index) => FittedBox(
                                  child: ImageViews(
                                      ontap: () {
                                        setState(() {
                                          images.removeAt(index);
                                        });
                                      },
                                      index: index,
                                      screenSize: screenSize,
                                      images: []),
                                ))),
                  ),
                  Card(
                    child: InkWell(
                        onTap: () async {
                          // XFile? img = await imagePicker.pickImage(
                          //     source: ImageSource.camera);
                          // setState(() {
                          //   try {
                          //     images.add(img!);
                          //   } on Exception {
                          //     // TODO
                          //   }
                          // });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.camera),
                        )),
                  ),
                  Card(
                    child: InkWell(
                        onTap: () async {
                          // images.addAll(await imagePicker.pickMultiImage());
                          setState(() {});
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.image),
                        )),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ref.watch(isEditedStateProvider) == false
                ? SpecialTextfield(
                    controller: answerController,
                    innerHint: 'input answer',
                  )
                : Container(
                    alignment: Alignment.center,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            width: 1, color: Theme.of(context).hintColor)),
                    child: Text(answerController.text.isEmpty
                        ? 'No input!'
                        : answerController.text)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: ElevatedButton(
                onPressed: () {
                  if (answerController.text.isNotEmpty &&
                      questionController.text.isNotEmpty) {
                    ref.watch(createdQuizlistdataProvider);
                    questionListWatcher.addQuiz(ShortAnswer(
                        images: [],
                        //images,
                        answer: answerController.text.trim(),
                        questions: questionController.text.trim()));
                  } else {
                    // CustomWidgets.styledSnackBar(
                    //     context: context,
                    //     message: 'input fields must not be empty');
                  }
                },
             //   style: CustomWidgets.chipStyleButton,
                child: Text(
                  'Add Quiz',
                  style: Styles.text,
                )),
          )
        ]),
      ),
    );
  }
}
