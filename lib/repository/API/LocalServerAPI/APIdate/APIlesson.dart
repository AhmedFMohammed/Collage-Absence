import 'dart:convert';

import 'package:schoolattendance/repository/API/LocalServerAPI/APIBASE.dart';
import 'package:schoolattendance/services/models/lesson.dart';

import 'package:http/http.dart';

class APILesson {
  APIHelper _apiHelper = APIHelper();
  Future<List<LessonModel>> getLesson() async {
    List<LessonModel> lesson = [];
    Response? response = await _apiHelper.get(path: "/lesson", Header: 2);
    List js = json.decode(response!.body);
    for (var j in js) {
      lesson.add(LessonModel.fromJson(j));
    }
    return lesson;
  }

  Future<LessonModel> AddLesson(LessonModel lesson) async {
    try {
      Response? response =
          await _apiHelper.post(path: "/lesson/", Header: 2, body: lesson);
    } catch (e) {
      print(e);
    }

    return lesson;
  }

  Future<LessonModel> EditLesson(LessonModel lesson) async {
    try {
      Response? response = await _apiHelper.put(
          path: "/lesson/${lesson.id}", Header: 2, body: lesson);
    } catch (e) {
      print(e);
    }

    return lesson;
  }

  Future<LessonModel> DeleteLesson(LessonModel lesson) async {
    try {
      Response? response =
          await _apiHelper.delete(path: "/lesson/${lesson.id}", Header: 2);
    } catch (e) {
      print(e);
    }

    return lesson;
  }
}
