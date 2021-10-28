import 'package:flutter/material.dart';

// Packages
import 'package:url_launcher/url_launcher.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Utils {
  static void showMessage(context, title, message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('$title'),
        content: Text('$message'),
        actions: [
          TextButton(
            onPressed: () {
              return Navigator.pop(_);
            },
            child: Text('OK'),
          )
        ],
      ),
    );
  }

  static Future<bool> checkInternetConnection() async {
    return await InternetConnectionChecker().hasConnection;
  }

  static launchURL() async {
    const url =
        'https://chat.blip.ai/?appKey=ZXRlcDE6MjI3ZTY2OWItMWUxYS00NDAxLTgxNzktMGYzNzUxOGJlNTQz';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
