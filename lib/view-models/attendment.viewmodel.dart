// Model
import 'package:projeto/models/attendment.dart';

// View Mode
import 'package:projeto/view-models/attendment.viewmodel.dart';

class AttendmentViewModel {
  String id = '';
  String name = '';
  String type = '';
  double price = 0;
  String description = '';
  List<String> units = [];
  String accept = '';
  String procedure = '';

  AttendmentViewModel(
    String id,
    String name,
    String type,
    double price,
    String description,
    List<String> units,
    String accept,
    String procedure,
  ) {
    this.id = id;
    this.name = name;
    this.type = type;
    this.price = price;
    this.description = description;
    this.units = units;
    this.accept = accept;
    this.procedure = procedure;
  }

  attendmentFromAttendmentModelToAttendmentViewModel(
      AttendmentModel attendmentViewModel) {
    this.id = attendmentViewModel.id;
    this.name = attendmentViewModel.name;
    this.type = attendmentViewModel.type;
    this.price = attendmentViewModel.price;
    this.description = attendmentViewModel.description;
    this.units = attendmentViewModel.units;
    this.accept = attendmentViewModel.accept;
    this.procedure = attendmentViewModel.procedure;
  }

  attendmentFromAttendmentViewModelToAttendmentModel(
      AttendmentModel attendmentModel) {
    return new AttendmentModel(
      attendmentModel.id,
      attendmentModel.name,
      attendmentModel.type,
      attendmentModel.price,
      attendmentModel.description,
      attendmentModel.units,
      attendmentModel.accept,
      attendmentModel.procedure,
    );
  }

  String toString() {
    return '{ id: ${this.id}, name: ${this.name}, type: ${this.type}, price: ${this.price}, description: ${this.description}, units: ${this.units}, accept: ${this.accept}, procedure: ${this.procedure}, }';
  }
}
