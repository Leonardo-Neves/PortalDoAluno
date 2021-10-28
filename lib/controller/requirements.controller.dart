import 'package:flutter/material.dart';

// Model
import 'package:projeto/models/base.model.dart';

// App
import 'package:projeto/repositories/student.repository.dart';

// Model
import 'package:projeto/models/attendment.dart';
import 'package:projeto/models/student.model.dart';
import 'package:projeto/models/requirement.model.dart';

// View Model
import 'package:projeto/view-models/attendment.viewmodel.dart';
import 'package:projeto/view-models/requirements.viewmodel.dart';

// View
import 'package:projeto/views/requirementsmessage.dart';

// Packages
import 'package:hive/hive.dart';

class RequirementsController extends BaseModel {
  final StudentRepository _api;

  RequirementsController({
    required StudentRepository api,
  }) : _api = api;

  Future<List<AttendmentViewModel>> getAttendments() async {
    List<AttendmentModel> attendmentsModel = await _api.getAttendment();

    List<AttendmentViewModel> attendmentsViewModel = [];

    for (var i = 0; i < attendmentsModel.length; i++) {
      AttendmentViewModel attendmentViewModel =
          new AttendmentViewModel('', '', '', 0, '', [], '', '');

      attendmentViewModel.attendmentFromAttendmentModelToAttendmentViewModel(
          attendmentsModel[i]);

      attendmentsViewModel.add(attendmentViewModel);
    }

    return attendmentsViewModel;
  }

  StudentModel getStudent() {
    var boxs = Hive.box('student');

    var student = boxs.get('user') as StudentModel;

    return student;
  }

  void postRequirements(
      RequirementViewModel requirementViewModel, BuildContext context) async {
    setBusy(true);
    RequirementModel requirementModel = requirementViewModel
        .requirementFromRequirementViewModelToRequirementModel(
            requirementViewModel);
    await _api.postRequirements(requirementModel);
    setBusy(false);

    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => RequirementsMessage(),
      ),
    );
  }

  Future<List<RequirementViewModel>> getRequirements(String idStudent) async {
    List<RequirementModel> requirementsModel =
        await _api.getRequirements(idStudent);

    List<RequirementViewModel> requirementsViewModel = [];

    for (var i = 0; i < requirementsModel.length; i++) {
      RequirementViewModel requirementViewModel = new RequirementViewModel(
          '',
          '',
          '',
          '',
          [],
          new AttendmentViewModel('', '', '', 0, '', [], '', ''),
          '');
      requirementViewModel
          .requirementFromRequirementModelToRequirementViewModel(
              requirementsModel[i]);

      requirementsViewModel.add(requirementViewModel);
    }

    return requirementsViewModel;
  }
}
