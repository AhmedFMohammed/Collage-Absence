import 'dart:convert';

import 'package:schoolattendance/repository/API/LocalServerAPI/APIdate/APIstudent.dart';
import 'package:schoolattendance/services/models/stage.dart';
import 'package:schoolattendance/services/models/student.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../APIBASE.dart';

class APIStage {
  APIHelper _apiHelper = APIHelper();
  APIStudent _apiStudent = APIStudent();

  Future<List<StageModel>> getStages() async {
    Response? response = await _apiHelper.get(path: "/stage", Header: 2);
    List<StageModel> stages = [];
    List js = json.decode(response!.body);

    for (var i in js) {
      StageModel stage = StageModel.fromJson(i);
      List<StudentModel> students = await _apiStudent.getStudent();
      int count = List<StudentModel>.from(students)
          .where((e) => e.stage == "${stage.id}")
          .length;

      stage.student_count = "$count";

      stages.add(stage);
    }

    return stages;
  }

  Future<StageModel> updateStage(StageModel stage) async {
    print(json.encode(stage.toJson()));
    _apiHelper.put(path: "/stage/${stage.id}", body: stage.toJson(), Header: 2);

    return await stage;
  }
}
