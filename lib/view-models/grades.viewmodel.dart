// Model
import 'package:projeto/models/grades.model.dart';

class GradesViewModel {
  String id = '';
  String code = '';
  double presencialEvaluation = 0;
  double performanceEvaluation = 0;
  double finalExam = 0;
  double semesterMean = 0;
  double finalMean = 0;
  String ra = '';

  GradesViewModel(
    String id,
    String code,
    double presencialEvaluation,
    double performanceEvaluation,
    double finalExam,
    double semesterMean,
    double finalMean,
    String ra,
  ) {
    this.id = id;
    this.code = code;
    this.presencialEvaluation = presencialEvaluation;
    this.performanceEvaluation = performanceEvaluation;
    this.finalExam = finalExam;
    this.semesterMean = semesterMean;
    this.finalMean = finalMean;
    this.ra = ra;
  }

  gradesFromGradesModelToGradesViewModel(GradesModel gradesModel) {
    this.id = gradesModel.id;
    this.code = gradesModel.code;
    this.presencialEvaluation = gradesModel.presencialEvaluation;
    this.performanceEvaluation = gradesModel.performanceEvaluation;
    this.finalExam = gradesModel.finalExam;
    this.semesterMean = gradesModel.semesterMean;
    this.finalMean = gradesModel.finalMean;
    this.ra = gradesModel.ra;
  }

  String toString() {
    return '{ ${this.id}, ${this.code}, ${this.presencialEvaluation}, ${this.performanceEvaluation}, ${this.finalExam}, ${this.semesterMean}, ${this.ra}, }';
  }
}
