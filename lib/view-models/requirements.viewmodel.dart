// Model
import 'package:projeto/models/attendment.dart';
import 'package:projeto/models/requirement.model.dart';
import 'package:projeto/view-models/attendment.viewmodel.dart';
import 'package:projeto/models/itemrequirement.model.dart';

class RequirementViewModel {
  String id = '';
  String protocolNumber = '';
  DateTime createdDate = new DateTime.now();
  String step = '';
  String status = '';
  List<ItemRequirementModel> solicitation = [];
  AttendmentViewModel attendment =
      new AttendmentViewModel('', '', '', 0, '', [], '', '');
  String unit = '';

  RequirementViewModel(
    String id,
    String protocolNumber,
    String step,
    String status,
    List<ItemRequirementModel> solicitation,
    AttendmentViewModel attendment,
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

  requirementFromRequirementViewModelToRequirementModel(
      RequirementViewModel requirementViewModel) {
    return new RequirementModel(
      requirementViewModel.id,
      requirementViewModel.protocolNumber,
      requirementViewModel.step,
      requirementViewModel.status,
      [],
      new AttendmentModel(
        requirementViewModel.attendment.id,
        requirementViewModel.attendment.name,
        requirementViewModel.attendment.type,
        requirementViewModel.attendment.price,
        requirementViewModel.attendment.description,
        requirementViewModel.attendment.units,
        requirementViewModel.attendment.accept,
        requirementViewModel.attendment.procedure,
      ),
      requirementViewModel.unit,
    );
  }

  requirementFromRequirementModelToRequirementViewModel(
      RequirementModel requirementModel) {
    this.id = requirementModel.id;
    this.protocolNumber = requirementModel.protocolNumber;
    this.step = requirementModel.step;
    this.status = requirementModel.status;
    this.solicitation = requirementModel.solicitation;
    attendment.attendmentFromAttendmentModelToAttendmentViewModel(
        requirementModel.attendment);
    this.unit = requirementModel.unit;
  }

  String toString() {
    return '{ id: ${this.id}, protocolNumber: ${this.protocolNumber}, createdDate: ${this.createdDate}, step: ${this.step}, status: ${this.status}, solicitation: ${this.solicitation}, attendment: ${this.attendment}, unit: ${this.unit}, }';
  }
}
