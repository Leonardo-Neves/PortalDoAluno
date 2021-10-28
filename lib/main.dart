import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Dependency Injection
import 'package:projeto/provider_setup.dart';

// Packages
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

// View
import 'package:projeto/views/signin.dart';
import 'package:projeto/views/requirements.dart';

// Hive
import 'package:projeto/models/student.model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Remove the System navigation bar
  //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  // System Device Orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();

    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(StudentModelAdapter());
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Hive.box('user').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Poppins'),
        home: FutureBuilder(
          future: Hive.openBox('student'),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return SignIn();
              }
            } else {
              return Scaffold();
            }
          },
        ),
      ),
    );
  }
}

//st = create a StalelessWidget
