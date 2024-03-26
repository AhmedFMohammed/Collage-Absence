import 'dart:convert';

import 'package:schoolattendance/repository/API/LocalServerAPI/APIBASE.dart';
import 'package:schoolattendance/services/models/profiles.dart';
import 'package:schoolattendance/services/models/teacher.dart';
import 'package:http/http.dart';

class APITeacher {
  APIHelper _apiHelper = APIHelper();

  Future<List<TeacherModel>> GetTeachers() async {
    List<TeacherModel> teachers = [];
    try {
      Response? response = await _apiHelper.get(
        path: "/accounts/user/",
        Header: 2,
      );
      List js = json.decode(response!.body);

      for (var j in js) {
        print(j);
        teachers.add(TeacherModel.fromJson(j));
      }

      return teachers;
    } catch (e) {
      print(e);
    }

    return teachers;
  }

  Future<List<Profile>> GetTeachersProfile() async {
    List<Profile> TeachersProfile = [];
    try {
      Response? response = await _apiHelper.get(
        path: "/accounts/user/profile",
        Header: 2,
      );
      List js = json.decode(response!.body);
      for (var j in js) {
        TeachersProfile.add(Profile.fromJson(j));
      }

      return TeachersProfile;
    } catch (e) {
      print(e);
    }

    return TeachersProfile;
  }

  Future<TeacherModel> AddTeacher(TeacherModel teacher) async {
    try {
      Response? response = await _apiHelper.post(
          path: "/accounts/user/teacher", Header: 2, body: teacher);
    } catch (e) {
      print(e);
    }

    return teacher;
  }

  Future<TeacherModel> EditTeacher(TeacherModel teacher) async {
    try {
      Response? response = await _apiHelper.put(
          path: "/accounts/user/teacher/${teacher.id}",
          Header: 2,
          body: teacher);
    } catch (e) {
      print(e);
    }

    return teacher;
  }

  Future<TeacherModel> DeleteTeacher(TeacherModel teacher) async {
    try {
      Response? response = await _apiHelper.delete(
          path: "/accounts/user/teacher/${teacher.id}", Header: 2);
    } catch (e) {
      print(e);
    }

    return teacher;
  }
}
