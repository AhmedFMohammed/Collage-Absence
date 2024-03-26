import 'dart:convert';

import 'package:schoolattendance/repository/API/LocalServerAPI/APIBASE.dart';
import 'package:schoolattendance/services/models/attendance.dart';

import 'package:http/http.dart';

class APIAttendance {
  APIHelper _apiHelper = APIHelper();
  Future<List<AttendanceModel>> getAttendance() async {
    List<AttendanceModel> attendance = [];
    Response? response = await _apiHelper.get(path: "/attendance", Header: 2);
    List js = json.decode(response!.body);
    for (var j in js) {
      attendance.add(AttendanceModel.fromJson(j));
    }
    return attendance;
  }

  Future<AttendanceModel> AddAttendance(AttendanceModel attendance) async {
    try {
      Response? response = await _apiHelper.post(
          path: "/attendance/", Header: 2, body: attendance);
    } catch (e) {
      print(e);
    }

    return attendance;
  }

  Future<AttendanceModel> EditAttendance(AttendanceModel attendance) async {
    try {
      Response? response = await _apiHelper.put(
          path: "/attendance/${attendance.id}", Header: 2, body: attendance);
    } catch (e) {
      print(e);
    }

    return attendance;
  }

  Future<AttendanceModel> DeleteAttendance(AttendanceModel attendance) async {
    try {
      Response? response = await _apiHelper.delete(
          path: "/attendance/${attendance.id}", Header: 2);
    } catch (e) {
      print(e);
    }

    return attendance;
  }
}
