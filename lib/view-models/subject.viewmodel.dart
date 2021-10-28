import 'package:projeto/view-models/grades.viewmodel.dart';
import 'package:projeto/view-models/lake.viewmodel.dart';

// Model
import 'package:projeto/models/subject.model.dart';

class SubjectViewModel {
  String id = '';
  String name = '';
  String workload = '';
  GradesViewModel grade = new GradesViewModel('', '', 0, 0, 0, 0, 0, '');
  List<LakeViewModel> lake = [];
  String ra = '';
  String status = '';
  String classes = '';
  String branch = '';

  subjectFromSubjectModelToSubjectViewModel(SubjectModel subjectModel) {
    this.id = subjectModel.id;
    this.name = subjectModel.name;
    this.workload = subjectModel.workload;
    this.grade.gradesFromGradesModelToGradesViewModel(subjectModel.grade);
    for (var i = 0; i < subjectModel.lake.length; i++) {
      LakeViewModel lakeModel = new LakeViewModel('', '', 0);
      lakeModel.lakeFromLakeModelToLakeViewModel(subjectModel.lake[i]);
      this.lake.add(lakeModel);
    }
    this.ra = subjectModel.ra;
    this.status = subjectModel.status;
    this.classes = subjectModel.classes;
    this.branch = subjectModel.branch;
  }

  String toString() {
    return '{ id: ${this.id}, name: ${this.name}, ra: ${this.ra}, workload: ${this.workload}, grade: { code: ${this.grade.code}, presencialEvaluation: ${this.grade.presencialEvaluation}, performanceEvaluation: ${this.grade.performanceEvaluation}, finalExam: ${this.grade.finalExam}, semesterMean: ${this.grade.semesterMean}, semesterMean: ${this.grade.finalMean}, ra: ${this.grade.ra}, } lake: ${this.lake}, ra: ${this.ra}, status: ${this.status}, classes: ${this.classes}, branch: ${this.branch}, }';
  }
}
