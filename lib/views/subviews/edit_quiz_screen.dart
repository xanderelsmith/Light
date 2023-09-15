import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/models/quizmodels/created_quiz_viewer_ui/question_model.dart';
import 'package:light/repository/quiz/created_quizdata_repository.dart';
import 'package:light/views/createquizui/previewcreatedquizscreen.dart';
import 'package:light/views/createquizui/quizcreatorscreenbuilder.dart';
import 'package:light/views/createquizui/side_editscreen.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../../enums/quiztype_enum.dart';
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
      body: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10))),
              child:
                  QuizCreatorBuilderScreen(value: ref.watch(quizTypeProvider)),
            ),
          ),
          Container(
            color: Colors.amber,
            width: screensize.width / 3,
            child: SideEditScreen(
              ref: ref,
              child: PreviewQuizScreen(
                quizdata: widget.quizdata,
              ),
            ),
          )
        ],
      ),
    );
  }
}
