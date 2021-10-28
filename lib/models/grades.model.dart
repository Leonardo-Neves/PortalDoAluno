class GradesModel {
  String id = '';
  String code = '';
  double presencialEvaluation = 0;
  double performanceEvaluation = 0;
  double finalExam = 0;
  double semesterMean = 0;
  double finalMean = 0;
  String ra = '';

  GradesModel(
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

  gradesFromJsonToObject(jsonGrades) {
    this.id = jsonGrades['_id'];
    this.code = jsonGrades['subjectCode'];
    this.presencialEvaluation =
        double.parse(jsonGrades['presencialEvaluation'].toString());
    this.performanceEvaluation =
        double.parse(jsonGrades['performanceEvaluation'].toString());
    this.finalExam = double.parse(jsonGrades['finalExam'].toString());
    this.semesterMean = double.parse(jsonGrades['semesterMean'].toString());
    this.finalMean = double.parse(jsonGrades['finalMean'].toString());
    this.ra = jsonGrades['ra'].toString();
  }

  String toString() {
    return '{ id: ${this.id}, code: ${this.code}, presencialEvaluation: ${this.presencialEvaluation}, performanceEvaluation: ${this.performanceEvaluation}, finalExam: ${this.finalExam}, semesterMean: ${this.semesterMean}, ra: ${this.ra}, }';
  }
}
