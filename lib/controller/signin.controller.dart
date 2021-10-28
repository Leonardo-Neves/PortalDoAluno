import 'package:flutter/material.dart';

// App
import 'package:projeto/repositories/student.repository.dart';
import 'package:projeto/modules/utils.dart';

// View Model
import 'package:projeto/view-models/signin.viewmodel.dart';

// Model
import 'package:projeto/models/base.model.dart';
import 'package:projeto/models/student.model.dart';

// View
import 'package:projeto/views/home.dart';

// Packages
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';

class SignInController extends BaseModel {
  final StudentRepository _api;

  SignInController({
    required StudentRepository api,
  }) : _api = api;

  Future<void> login(SignInViewModel model, BuildContext context) async {
    setBusy(true);

    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var student = await _api.login(model);

    if (student.name != "") {
      localStorage.remove('user');

      Hive.box('student').put('user', student);
      setBusy(false);
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    } else {
      setBusy(false);
      Utils.showMessage(
        context,
        'Erro',
        'Usuário ou senha incorreta',
      );
    }
  }

  StudentModel getStudent() {
    var boxs = Hive.box('student');

    var student = boxs.get('user') as StudentModel;

    return student;
  }
}
