class FinanceModel {
  String id = '';
  String idStudent = '';
  double quota = 0;
  String responsible = '';
  double conditionalDiscount = 0;
  double grossValue = 0;
  String service = '';
  String competence = '';
  double parcel = 0;
  String status = '';
  double scholarshipInconditional = 0;
  double fees = 0;
  String dueDate = '';
  double downloaded = 0;
  double fine = 0;
  double discount = 0;
  double netValue = 0;

  FinanceModel(
    String id,
    String idStudent,
    double quota,
    String responsible,
    double conditionalDiscount,
    double grossValue,
    String service,
    String competence,
    double parcel,
    String status,
    double scholarshipInconditional,
    double fees,
    String dueDate,
    double downloaded,
    double fine,
    double discount,
    double netValue,
  ) {
    this.id = id;
    this.idStudent = idStudent;
    this.quota = quota;
    this.responsible = responsible;
    this.conditionalDiscount = conditionalDiscount;
    this.grossValue = grossValue;
    this.service = service;
    this.competence = competence;
    this.parcel = parcel;
    this.status = status;
    this.scholarshipInconditional = scholarshipInconditional;
    this.fees = fees;
    this.dueDate = dueDate;
    this.downloaded = downloaded;
    this.fine = fine;
    this.discount = discount;
    this.netValue = netValue;
  }

  financeFromJsonToObject(jsonFinance) {
    this.id = jsonFinance['_id'];
    this.idStudent = jsonFinance['idStudent'];
    this.quota = jsonFinance['quota'].toDouble();
    this.responsible = jsonFinance['responsible'];
    this.conditionalDiscount = jsonFinance['conditionalDiscount'].toDouble();
    this.grossValue = jsonFinance['grossValue'].toDouble();
    this.service = jsonFinance['service'];
    this.competence = jsonFinance['competence'];
    this.parcel = jsonFinance['parcel'].toDouble();
    this.status = jsonFinance['status'];
    this.scholarshipInconditional =
        jsonFinance['scholarshipInconditional'].toDouble();
    this.fees = jsonFinance['fees'].toDouble();
    this.dueDate = jsonFinance['dueDate'];
    this.downloaded = jsonFinance['downloaded'].toDouble();
    this.fine = jsonFinance['fine'].toDouble();
    this.discount = jsonFinance['discount'].toDouble();
    this.netValue = jsonFinance['netValue'].toDouble();
  }

  String toString() {
    return '{ id: ${this.id}, idStudent: ${this.idStudent}, quota: ${this.quota}, responsible: ${this.responsible}, conditionalDiscount: ${this.conditionalDiscount}, grossValue: ${this.grossValue}, service: ${this.service}, competence: ${this.competence}, parcel: ${this.parcel}, status: ${this.status}, scholarshipInconditional: ${this.scholarshipInconditional}, fees: ${this.fees}, dueDate: ${this.dueDate}, downloaded: ${this.downloaded}, fine: ${this.fine}, discount: ${this.discount}, netValue: ${this.netValue}, }';
  }
}
