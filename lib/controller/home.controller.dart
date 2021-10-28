import 'package:flutter/material.dart';

// Model
import 'package:projeto/models/news.model.dart';
import 'package:projeto/models/student.model.dart';

// App
import 'package:projeto/repositories/student.repository.dart';
import 'package:projeto/models/base.model.dart';

// View
import 'package:projeto/views/signin.dart';

// Packages
import 'package:hive/hive.dart';

class HomeController extends BaseModel {
  final StudentRepository _api;

  HomeController({
    required StudentRepository api,
  }) : _api = api;

  void logout(BuildContext context) async {
    var box = Hive.box('student');

    box.delete('user');

    await Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => SignIn(),
      ),
    );
  }

  Future<List> getImagesNews() async {
    var imagesNews = [];

    List<NewsModel> imageNewsModel = await _api.getImagesNews();

    for (var i = 0; i < imageNewsModel.length; i++) {
      imagesNews.add(imageNewsModel[i].url);
    }

    return imagesNews;
  }

  dynamic getStudent() {
    var box = Hive.box('student');

    var student = box.get('user') as StudentModel;

    return student;
  }
}
