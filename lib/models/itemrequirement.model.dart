// Model
import 'package:projeto/models/attendment.dart';

class ItemRequirementModel {
  String label = '';
  DateTime createdDate = new DateTime.now();

  ItemRequirementModel(
    String label,
  ) {
    this.label = label;
  }

  String toString() {
    return '{ id: ${this.label}, protocolNumber: ${this.createdDate},  }';
  }
}
