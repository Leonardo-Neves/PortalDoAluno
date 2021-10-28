// App
import 'package:projeto/repositories/student.repository.dart';
import 'package:projeto/models/base.model.dart';

// Model
import 'package:projeto/models/subject.model.dart';

// View Model
import 'package:projeto/view-models/subject.viewmodel.dart';

// View
import 'package:projeto/models/student.model.dart';

// Packages
import 'package:hive/hive.dart';

class GradesController extends BaseModel {
  final StudentRepository _api;

  GradesController({
    required StudentRepository api,
  }) : _api = api;

  Future<List<SubjectViewModel>> getGrades(String ra, String? period) async {
    List<SubjectModel> subjects = await _api.getGrades(ra, period);

    List<SubjectViewModel> listSubjectsViewModel = [];

    for (var i = 0; i < subjects.length; i++) {
      SubjectViewModel subjectViewModel = new SubjectViewModel();

      subjectViewModel.subjectFromSubjectModelToSubjectViewModel(subjects[i]);

      listSubjectsViewModel.add(subjectViewModel);
    }

    return listSubjectsViewModel;
  }

  dynamic getStudent() {
    var box = Hive.box('student');

    var student = box.get('user') as StudentModel;

    return student;
  }

  Future<List<String>> getPeriod(String ra) async {
    return await _api.getPeriod(ra);
  }
}
