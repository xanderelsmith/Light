import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/quizmodels/base_create_quiz_ui_data.dart';

//for monitoring the created quiz list data
class CreatedQuizRepository extends StateNotifier<List<QuizViewFormat>> {
  CreatedQuizRepository() : super([]);

  void addQuiz(QuizViewFormat value) {
    state = [...state, value];
  }

  void clearData() {
    state.clear();
  }

  void remove(int index) {
    final detailsListValue = state;
    detailsListValue.removeAt(index);
    state = [...detailsListValue];
  }

  void updateQuiz() {}
  int get getListLength => state.length;
}
