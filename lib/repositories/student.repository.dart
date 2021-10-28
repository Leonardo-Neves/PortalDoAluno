// Models
import 'package:projeto/models/news.model.dart';
import 'package:projeto/models/student.model.dart';
import 'package:projeto/models/subject.model.dart';
import 'package:projeto/models/finance.model.dart';
import 'package:projeto/models/attendment.dart';
import 'package:projeto/models/requirement.model.dart';

// View Model
import 'package:projeto/view-models/signin.viewmodel.dart';

// Packages
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentRepository {
  Future<StudentModel> login(SignInViewModel model) async {
    var url = Uri.parse(
      'https://etepprojetoapp.wixsite.com/my-site/_functions-dev/login',
    );

    var student = new StudentModel();

    try {
      var response = await http.post(
        url,
        body: jsonEncode(
          {
            'ra': model.ra,
            'password': model.password,
          },
        ),
      );

      var jsonStudent = jsonDecode(response.body);

      if (response.body != '{}') {
        student.studentFromJsonToObject(jsonStudent);
        return student;
      } else {
        return student;
      }
    } catch (e) {
      print('StudentRepository - login: $e');
    }
    return student;
  }

  Future<List<NewsModel>> getImagesNews() async {
    var url = Uri.parse(
      'https://etepprojetoapp.wixsite.com/my-site/_functions-dev/news',
    );
    var response, imagesArray = [];
    List<NewsModel> imagesNews = [];

    try {
      response = await http.get(url);

      imagesArray = jsonDecode(response.body);

      for (var i = 0; i < imagesArray.length; i++) {
        NewsModel newsModel = new NewsModel();

        newsModel.imageFromJsonToObject(imagesArray[i]);

        imagesNews.add(newsModel);
      }
    } catch (e) {
      print('StudentRepository - getImagesNews: $e');
    }

    return imagesNews;
  }

  Future<List<SubjectModel>> getGrades(String ra, String? perid) async {
    var url = Uri.parse(
      'https://etepprojetoapp.wixsite.com/my-site/_functions-dev/grades?ra=${ra}&period=${perid}',
    );
    List<SubjectModel> subjectsObject = [];
    try {
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var subjects = jsonDecode(response.body);

        if (subjects.isNotEmpty) {
          for (var i = 0; i < subjects.length; i++) {
            var subject = new SubjectModel();

            subject.subjectFromJsonToObject(subjects[i]);

            subjectsObject.add(subject);
          }
        }
      }
    } catch (e) {
      print('StudentRepository - getGrades: $e');
    }

    return subjectsObject;
  }

  Future<List<String>> getPeriod(String ra) async {
    var url = Uri.parse(
      'https://etepprojetoapp.wixsite.com/my-site/_functions-dev/period?ra=${ra}',
    );

    List<String> period = [];

    try {
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var periods = jsonDecode(response.body);

        for (var i = 0; i < periods.length; i++) {
          period.add(periods[i].toString());
        }

        return period;
      }
    } catch (e) {
      print('StudentRepository - getPeriod: $e');
    }

    return period;
  }

  Future<List<FinanceModel>> getFinance(String period) async {
    var url = Uri.parse(
      'https://etepprojetoapp.wixsite.com/my-site/_functions-dev/finance?period=${period}',
    );

    List<FinanceModel> financesModel = [];
    try {
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        List payments = jsonDecode(response.body);

        for (var i = 0; i < payments.length; i++) {
          FinanceModel financeModel = new FinanceModel(
              '', '', 0, '', 0, 0, '', '', 0, '', 0, 0, '', 0, 0, 0, 0);

          financeModel.financeFromJsonToObject(payments[i]);

          financesModel.add(financeModel);
        }
      }
    } catch (e) {
      print('StudentRepository - getFinance: $e');
    }

    return financesModel;
  }

  Future<List<AttendmentModel>> getAttendment() async {
    var url = Uri.parse(
      'https://etepprojetoapp.wixsite.com/my-site/_functions-dev/attendment',
    );

    List<AttendmentModel> attendmentsModel = [];

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      List attendments = jsonDecode(response.body);

      for (var i = 0; i < attendments.length; i++) {
        AttendmentModel attendmentModel =
            new AttendmentModel('', '', '', 0, '', [], '', '');

        attendmentModel.attendmentFromJsonToObject(attendments[i]);

        attendmentsModel.add(attendmentModel);
      }
    }

    return attendmentsModel;
  }

  Future<void> postRequirements(RequirementModel requirementModel) async {
    var url = Uri.parse(
      'https://etepprojetoapp.wixsite.com/my-site/_functions-dev/requirement',
    );

    try {
      http.Response response = await http.post(
        url,
        body: jsonEncode({
          'id': requirementModel.id,
          'protocolNumber': requirementModel.protocolNumber,
          'step': requirementModel.step,
          'status': requirementModel.status,
          'solicitation': requirementModel.solicitation,
          'attendment': requirementModel.attendment.id,
          'unit': requirementModel.unit,
          'createdDate': '${requirementModel.createdDate}',
        }),
      );

      if (response.statusCode == 200) {}
    } catch (e) {
      print('StudentRepository - postRequirements: $e');
    }
  }

  Future<List<RequirementModel>> getRequirements(String idStudent) async {
    var url = Uri.parse(
      'https://etepprojetoapp.wixsite.com/my-site/_functions-dev/requirement',
    );

    List<RequirementModel> requirementsModel = [];

    try {
      http.Response response =
          await http.get(url, headers: {'idStudent': idStudent});

      if (response.statusCode == 200) {
        List requirements = jsonDecode(response.body);

        for (var i = 0; i < requirements.length; i++) {
          RequirementModel requirementModel = new RequirementModel('', '', '',
              '', [], new AttendmentModel('', '', '', 0, '', [], '', ''), '');
          requirementModel.requirementFromJsonToObject(requirements[i]);

          requirementsModel.add(requirementModel);
        }
      }
    } catch (e) {
      print('StudentRepository - getRequirements: $e');
    }

    return requirementsModel;
  }
}
