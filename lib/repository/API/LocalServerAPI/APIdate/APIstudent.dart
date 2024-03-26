import 'dart:convert';

import 'package:schoolattendance/repository/API/LocalServerAPI/APIBASE.dart';
import 'package:schoolattendance/services/models/student.dart';
import 'package:http/http.dart';

class APIStudent {
  APIHelper _apiHelper = APIHelper();
  Future<List<StudentModel>> getStudent() async {
    List<StudentModel> students = [];
    Response? response = await _apiHelper.get(path: "/student", Header: 2);
    List js = json.decode(response!.body);
    for (var j in js) {
      students.add(StudentModel.fromJson(j));
    }
    return students;
  }

  Future<StudentModel> AddStudent(StudentModel student) async {
    try {
      Response? response =
          await _apiHelper.post(path: "/student/", Header: 2, body: student);
    } catch (e) {
      print(e);
    }

    return student;
  }

  Future<StudentModel> EditStudent(StudentModel student) async {
    try {
      Response? response = await _apiHelper.put(
          path: "/student/${student.id}", Header: 2, body: student);
    } catch (e) {
      print(e);
    }

    return student;
  }

  Future<StudentModel> DeleteStudent(StudentModel student) async {
    try {
      Response? response =
          await _apiHelper.delete(path: "/student/${student.id}", Header: 2);
    } catch (e) {
      print(e);
    }

    return student;
  }
}
