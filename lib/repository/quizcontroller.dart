import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:light/enums/quiz_status.dart';
import 'package:light/enums/quiztype_enum.dart';
import 'package:light/models/question.dart';
import 'package:light/models/quizmodels/quizstate.dart';

class QuizController extends ChangeNotifier {
  QuizState quizstate = QuizState.initial();
  clearQuizState() {
    quizstate = quizstate.copyWith(
        correct: [],
        incorrect: [],
        selectedAnswer: '',
        status: QuizStatus.initial);
  }

  void submitAnswer(Question currentquestion, dynamic answer) {
    //checks if the quiz is complete
    if (quizstate.answered) return;
    //checks if the question is multichoice to add it to a controller
    log(currentquestion.correctanswer);
    log(answer);

    log((currentquestion.correctanswer == answer).toString());
    if (currentquestion.correctanswer == answer) {
      quizstate = quizstate.copyWith(
          status: QuizStatus.correct,
          selectedAnswer: answer,
          correct: [...quizstate.correct, currentquestion]);
    } else {
      quizstate = quizstate.copyWith(
        status: QuizStatus.incorrect,
        incorrect: [...quizstate.incorrect, currentquestion],
        selectedAnswer: answer,
      );
    }

    notifyListeners();
  }

  ///sets the quiz to be complete or initial (which would be checked to proceed to quiz view screen results)
  void nextQuestion(List<Question> question, int currentindex) {
    quizstate = quizstate.copyWith(
        selectedAnswer: '',
        status: currentindex + 1 < question.length
            ? QuizStatus.initial
            : QuizStatus.complete);

    notifyListeners();
  }

  void reset() {
    quizstate = QuizState.initial();

    notifyListeners();
  }
}

// void wrongSelectionSound() {
//   AudioPlayer plyr = AudioPlayer();
//   plyr.play(AssetSource('wronganswer.mp3'));
// }

// void successSound() {
//   AudioPlayer plyr = AudioPlayer();
//   plyr.play(AssetSource('correct.mp3'));
// }
