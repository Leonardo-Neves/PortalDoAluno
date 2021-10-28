import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// Repositories
import 'package:projeto/repositories/student.repository.dart';

// Controllers
import 'package:projeto/controller/signin.controller.dart';
import 'package:projeto/controller/home.controller.dart';
import 'package:projeto/controller/grades.controller.dart';
import 'package:projeto/controller/schedule.controller.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
];

List<SingleChildWidget> independentServices = [
  Provider.value(
    value: StudentRepository(),
  ),
];
List<SingleChildWidget> dependentServices = [
  ProxyProvider<StudentRepository, SignInController>(
    update: (context, api, signInController) => SignInController(api: api),
  ),
  ProxyProvider<StudentRepository, HomeController>(
    update: (context, api, homeController) => HomeController(api: api),
  ),
  ProxyProvider<StudentRepository, GradesController>(
    update: (context, api, gradesController) => GradesController(api: api),
  ),
  ProxyProvider<StudentRepository, ScheduleController>(
    update: (context, api, gradesController) => ScheduleController(api: api),
  ),
];
List<SingleChildWidget> uiConsumableProviders = [
  //StreamProvider<StudentModel>(initialData: new StudentModel(), create: new StudentModel(), builder: (context) => Provider.of<SignInController>(context, listen: false).studentRepository,),
];
