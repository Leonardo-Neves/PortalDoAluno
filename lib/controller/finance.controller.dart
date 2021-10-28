// App
import 'package:projeto/repositories/student.repository.dart';
import 'package:projeto/models/base.model.dart';

// View Model
import 'package:projeto/view-models/finance.viewmodel.dart';

// View
import 'package:projeto/models/student.model.dart';

// Packages
import 'package:hive/hive.dart';

class FinanceController extends BaseModel {
  final StudentRepository _api;

  FinanceController({
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

  Future<List<FinanceViewModel>> getFinance(String period) async {
    var financesModel = await _api.getFinance(period);

    List<FinanceViewModel> financesViewModel = [];

    for (var i = 0; i < financesModel.length; i++) {
      FinanceViewModel financeViewModel = new FinanceViewModel(
          '', '', 0, '', 0, 0, '', '', 0, '', 0, 0, '', 0, 0, 0, 0);
      financeViewModel
          .financeFromFinanceModelToFinanceViewModel(financesModel[i]);
      financesViewModel.add(financeViewModel);
    }

    return financesViewModel;
  }
}
