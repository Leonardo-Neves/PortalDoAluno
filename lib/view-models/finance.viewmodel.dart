// Model
import 'package:projeto/models/finance.model.dart';

// Packages
import 'package:intl/intl.dart';

class FinanceViewModel {
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

  FinanceViewModel(
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

  financeFromFinanceModelToFinanceViewModel(FinanceModel financeModel) {
    this.id = financeModel.id;
    this.idStudent = financeModel.idStudent;
    this.quota = financeModel.quota;
    this.responsible = financeModel.responsible;
    this.conditionalDiscount = financeModel.conditionalDiscount;
    this.grossValue = financeModel.grossValue;
    this.service = financeModel.service;
    this.competence = financeModel.competence;
    this.parcel = financeModel.parcel;
    this.status = financeModel.status;
    this.scholarshipInconditional = financeModel.scholarshipInconditional;
    this.fees = financeModel.fees;
    this.dueDate = financeModel.dueDate;
    this.downloaded = financeModel.downloaded;
    this.fine = financeModel.fine;
    this.discount = financeModel.discount;
    this.netValue = financeModel.netValue;
  }

  financeDateToMonth(date) {
    var month = int.parse(
        '${DateFormat('dd/MM/yyyy').format(DateTime.parse(date))}'
            .split('/')[1]);
    switch (month) {
      case 1:
        return 'Janeiro';
      case 2:
        return 'Fevereiro';
      case 3:
        return 'Março';
      case 4:
        return 'Abril';
      case 5:
        return 'Maio';
      case 6:
        return 'Junho';
      case 7:
        return 'Julho';
      case 8:
        return 'Agosto';
      case 9:
        return 'Setembro';
      case 10:
        return 'Outubro';
      case 11:
        return 'Novembro';
      case 12:
        return 'Dezembro';
    }
  }

  String toString() {
    return '{ id: ${this.id}, idStudent: ${this.idStudent}, quota: ${this.quota}, responsible: ${this.responsible}, conditionalDiscount: ${this.conditionalDiscount}, grossValue: ${this.grossValue}, service: ${this.service}, competence: ${this.competence}, parcel: ${this.parcel}, status: ${this.status}, scholarshipInconditional: ${this.scholarshipInconditional}, fees: ${this.fees}, dueDate: ${this.dueDate}, downloaded: ${this.downloaded}, fine: ${this.fine}, discount: ${this.discount}, netValue: ${this.netValue}, }';
  }
}
