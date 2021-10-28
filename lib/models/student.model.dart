// Packages
import 'package:hive/hive.dart';

part 'student.model.g.dart';

@HiveType(typeId: 0)
class StudentModel extends HiveObject {
  @HiveField(0)
  String? id = '';
  @HiveField(1)
  String? name = '';
  @HiveField(2)
  String? ra = '';
  @HiveField(3)
  String? birthday = '';
  @HiveField(4)
  String? cpf = '';
  @HiveField(5)
  String? adress = '';
  @HiveField(6)
  String? rg = '';
  @HiveField(7)
  String? course = '';

  UserModel(String id, String name, String ra, String birthday, String cpf,
      String adress, String rg, String course) {
    this.id = id;
    this.name = name;
    this.ra = ra;
    this.birthday = birthday;
    this.cpf = cpf;
    this.adress = adress;
    this.rg = rg;
    this.course = course;
  }

  studentFromJsonToObject(jsonStudent) {
    this.id = jsonStudent['_id'].toString();
    this.name = jsonStudent['name'].toString();
    this.ra = jsonStudent['ra'].toString();
    this.birthday = jsonStudent['birthday'].toString();
    this.cpf = jsonStudent['cpf'].toString();
    this.adress = jsonStudent['adress'].toString();
    this.rg = jsonStudent['rg'].toString();
    this.course = jsonStudent['course'].toString();
  }

  studentFromObjectToJson() {
    return {
      'id': this.id,
      'name': this.name,
      'ra': this.ra,
      'birthday': this.birthday,
      'cpf': this.cpf,
      'adress': this.adress,
      'rg': this.rg,
      'course': this.course
    };
  }

  String toString() {
    return '{ id: ${this.id}, name: ${this.name}, ra: ${this.ra}, birthday: ${this.birthday}, cpf: ${this.cpf}, adress: ${this.adress}, rg: ${this.rg}, course: ${this.course}, }';
  }
}
