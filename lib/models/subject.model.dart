// Model
import 'package:projeto/models/grades.model.dart';
import 'package:projeto/models/lake.model.dart';

class SubjectModel {
  String id = '';
  String name = '';
  String workload = '';
  GradesModel grade = new GradesModel('', '', 0, 0, 0, 0, 0, '');
  List<LakeModel> lake = [];
  String ra = '';
  String status = '';
  String classes = '';
  String branch = '';

  subjectFromJsonToObject(jsonSubject) {
    this.id = jsonSubject['_id'];
    this.name = jsonSubject['name'];
    this.workload = jsonSubject['workload'].toString();
    this.grade.gradesFromJsonToObject(jsonSubject['grade']);
    for (var i = 0; i < jsonSubject['lake'].length; i++) {
      LakeModel lakeModel = new LakeModel('', '', 0);
      lakeModel.gradesFromJsonToObject(jsonSubject['lake'][i]);
      this.lake.add(lakeModel);
    }
    this.ra = jsonSubject['ra'].toString();
    this.status = jsonSubject['status'].toString();
    this.classes = jsonSubject['class'].toString();
    this.branch = jsonSubject['branch'].toString();
  }

  String toString() {
    return '{ id: ${this.id}, name: ${this.name}, ra: ${this.ra}, workload: ${this.workload}, grade: { code: ${this.grade.code}, presencialEvaluation: ${this.grade.presencialEvaluation}, performanceEvaluation: ${this.grade.performanceEvaluation}, finalExam: ${this.grade.finalExam}, semesterMean: ${this.grade.semesterMean}, ra: ${this.grade.ra}, } lake: ${this.lake}, ra: ${this.ra}, status: ${this.status}, classes: ${this.classes}, branch: ${this.branch}, }';
  }
}
