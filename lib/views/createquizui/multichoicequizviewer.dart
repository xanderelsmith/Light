import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/models/quizmodels/created_quiz_viewer_ui/question_model.dart';
import 'package:light/repository/created_quizdata_repository.dart';
import 'package:light/utils/constants.dart';
import 'package:light/views/createquizui/previewcreatedquizscreen.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../../enums/quiztype_enum.dart';
import 'package:flutter/services.dart';

//a provider for watching createdListData
final createdQuizlistdataProvider =
    StateNotifierProvider<CreatedQuizRepository, List<Question>>(
        (ref) => CreatedQuizRepository());

//a provider for watching quiztype of quizcreationscree
StateProvider<QuizType> quizTypeProvider = StateProvider<QuizType>((ref) {
  return QuizType.multichoice;
});

class CreateQuizScreen extends ConsumerStatefulWidget {
  const CreateQuizScreen({super.key, this.quizdata});
  static String id = 'createquiz';
  final ParseObject? quizdata;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateQuizScreenState();
}

var externaljsondatatextEditingController = TextEditingController();

class _CreateQuizScreenState extends ConsumerState<CreateQuizScreen> {
  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                icon: const Icon(Icons.smart_toy_outlined), onPressed: () {})
          ],
          centerTitle: true,
          title: const Text('Create your own quiz'),
          leading: IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text('Yes')),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No'))
                          ],
                          title: const Text('Are you sure you want to cancel '),
                        ));
              },
              icon: const Icon(Icons.chevron_left))),
      body: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        child: Column(children: [
          Card(
            elevation: 0,
            color: Theme.of(context).canvasColor.withOpacity(0.5),
            child: FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    3,
                    (index) => GestureDetector(
                          onTap: () {
                            // ref.watch(quizTypeProvider.notifier).state =
                            //     quizTypeChecker(index);
                          },
                          child: Card(
                              // color: ref.watch(quizTypeProvider) ==
                              //         quizTypeChecker(index)
                              //     ? Styles.primaryThemeColor
                              //     : Colors.transparent,
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(index == 0
                                ? 'MultiChoice'
                                : index == 1
                                    ? 'shortTextAnswer'
                                    : 'Drag and Drop'),
                          )),
                        )),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: ElevatedButton.icon(
                icon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('Validate:'),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 20,
                  backgroundColor: Constants.primaryColor,
                  shadowColor: Theme.of(context).canvasColor.withOpacity(0.3),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PreviewQuizScreen(
                                quizdata: widget.quizdata,
                              )));
                },
                label: Text('${ref.watch(createdQuizlistdataProvider).length}'),
              )),
        ]),
      ),
    );
  }
}
