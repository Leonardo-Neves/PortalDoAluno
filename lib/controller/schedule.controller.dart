// App
import 'package:projeto/repositories/student.repository.dart';

// Model
import 'package:projeto/models/base.model.dart';
import 'package:projeto/models/student.model.dart';

// Packages
import 'package:hive/hive.dart';

class ScheduleController extends BaseModel {
  final StudentRepository _api;

  ScheduleController({
    required StudentRepository api,
  }) : _api = api;

  Future<List<String>> getPeriod(String ra) async {
    return await _api.getPeriod(ra);
  }

  dynamic getStudent() {
    var box = Hive.box('student');

    var student = box.get('user') as StudentModel;

    return student;
  }
}
