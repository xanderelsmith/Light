import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/models/students_data_model.dart';

class StudentsListNotifier extends StateNotifier<List<StudentsModel>> {
  //make the super a list from a database

  StudentsListNotifier() : super([]);

  void add(StudentsModel studentDataModel) {
    List<StudentsModel> _studentDataModel = [...state];
    _studentDataModel.add(studentDataModel);
    state = _studentDataModel;
  }

  void remove(StudentsModel studentDataModel) {
    state = state
        .where(
            (StudentsModel studentmodel) => studentmodel != studentDataModel)
        .toList();
  }
}
