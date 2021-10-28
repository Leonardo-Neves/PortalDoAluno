// Model
import 'package:projeto/models/attendment.dart';
import 'package:projeto/models/itemrequirement.model.dart';

class RequirementModel {
  String id = '';
  String protocolNumber = '';
  DateTime createdDate = new DateTime.now();
  String step = '';
  String status = '';
  List<ItemRequirementModel> solicitation = [];
  AttendmentModel attendment =
      new AttendmentModel('', '', '', 0, '', [], '', '');
  String unit = '';

  RequirementModel(
    String id,
    String protocolNumber,
    String step,
    String status,
    List<ItemRequirementModel> solicitation,
    AttendmentModel attendment,
    String unit,
  ) {
    this.id = id;
    this.protocolNumber = protocolNumber;
    this.step = step;
    this.status = status;
    this.solicitation = solicitation;
    this.attendment = attendment;
    this.unit = unit;
  }

  requirementFromJsonToObject(jsonRequirements) {
    this.id = jsonRequirements['_id'].toString();
    this.protocolNumber = jsonRequirements['protocolNumber'].toString();
    this.step = jsonRequirements['step'].toString();
    this.status = jsonRequirements['status'].toString();
    this.solicitation = jsonRequirements['solicitation'];
    attendment.attendmentFromJsonToObject(jsonRequirements['attendment']);
    this.unit = jsonRequirements['unit'].toString();
    this.createdDate = DateTime.parse(jsonRequirements['createdDate']);
  }

  String toString() {
    return '{ id: ${this.id}, protocolNumber: ${this.protocolNumber}, createdDate: ${this.createdDate}, step: ${this.step}, status: ${this.status}, solicitation: ${this.solicitation}, attendment: ${this.attendment}, unit: ${this.unit}, }';
  }
}
