import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/quizmodels/base_create_quiz_ui_data.dart';
import 'package:light/views/createquizui/previewcreatedquizscreen.dart';
import '../../db_handler/styles.dart';
import '../../repository/created_quizdata_repository.dart';
import 'multichoicequizscreen.dart';

//a provider for watching createdListData
final createdQuizlistdataProvider =
    StateNotifierProvider<CreatedQuizRepository, List<QuizViewFormat>>(
        (ref) => CreatedQuizRepository());

class CreateQuizScreen extends HookConsumerWidget {
  const CreateQuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
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
          Expanded(
              //checks the quiztype from a list and returns based on its data(e.g multichoice)
              child: MultiChoiceCreator()),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 20,
                  backgroundColor: Styles.primaryThemeColor,
                  shadowColor: Theme.of(context).canvasColor.withOpacity(0.3),
                  shape: const CircleBorder(),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PreviewQuizScreen()));
                },
                child: Text('${ref.watch(createdQuizlistdataProvider).length}'),
              )),
        ]),
      ),
    );
  }
}
