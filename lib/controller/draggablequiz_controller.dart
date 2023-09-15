import 'package:hooks_riverpod/hooks_riverpod.dart';

class DraggableQuestionListValueClass
    extends StateNotifier<DraggableQuestionDetails> {
  DraggableQuestionListValueClass()
      : super(DraggableQuestionDetails(questionWords: [
          'Science',
          'is',
          'the',
          'ethos',
          'of',
          ' all',
        ], answers: [
          DraggableAnswerDetails(
            answer: 'Science',
            isEdited: false,
          ),
          DraggableAnswerDetails(
            answer: 'pothos',
            isEdited: false,
          )
        ]));

  List<String>? get questionlistValue => state.questionWords;
  List<DraggableAnswerDetails>? get questionAnswer => state.answers;
  List<String>? get questionAnswerValues {
    List<String> myList = [];

    for (var element in state.answers) {
      myList.add(element.answer.toString());
    }
    return myList;
  }

  void updateAnAnswerValue(
      {required DraggableAnswerDetails value, required int index}) {
    final answerstext = state.answers;
    answerstext[index].answer = value.answer;
    state = state.copyWith(answers: answerstext);
  }

//for editing the answer through a boolean
  void updateboolValue(int index) {
    final answerstextboolean = state.answers;
    answerstextboolean[index].isEdited =
        answerstextboolean[index].isEdited == true ? false : true;
    state = state.copyWith(answers: answerstextboolean);
  }

  void updateAnswers(DraggableAnswerDetails newValue) {
    final List<DraggableAnswerDetails> answerstextList = state.answers;
    List checker = List.generate(
        answerstextList.length, (index) => answerstextList[index].answer);
    if (checker.contains(newValue.answer) == false) {
      answerstextList.add(newValue);
    } else {
      answerstextList
          .removeWhere((element) => newValue.answer == element.answer);
    }
    state = state.copyWith(answers: answerstextList);
  }

  void addDummyData(DraggableAnswerDetails value) {
    final answerstextList = state.answers;

    answerstextList.add(value);

    state = state.copyWith(
      answers: answerstextList,
    );
  }

  void deleteoption({required DraggableAnswerDetails value}) {
    final answerstextList = state.answers;
    answerstextList.remove(value);
    state = state.copyWith(
      answers: answerstextList,
    );
  }

  void updateQuestions(List newValue) {
    final questiontextList = state.questionWords;
    questiontextList!.clear();
    for (var element in newValue) {
      questiontextList.add(element);
    }
    state = state.copyWith(questionWords: questiontextList);
  }
}

//class holding important draggable quiz answers data
class DraggableAnswerDetails {
  String? answer;
  bool? isEdited;
  DraggableAnswerDetails({
    required this.isEdited,
    required this.answer,
  });
}

class DraggableQuestionDetails {
  List<String>? questionWords;
  List<DraggableAnswerDetails> answers;
  DraggableQuestionDetails({
    required this.answers,
    required this.questionWords,
  });

  DraggableQuestionDetails copyWith(
      {List<String>? questionWords, List<DraggableAnswerDetails>? answers}) {
    return DraggableQuestionDetails(
      questionWords: questionWords ?? this.questionWords,
      answers: answers ?? this.answers,
    );
  }
}
