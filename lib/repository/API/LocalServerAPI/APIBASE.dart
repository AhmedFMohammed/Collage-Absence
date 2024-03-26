import 'dart:convert';

import 'package:schoolattendance/repository/auth/userAuth.dart';
import 'package:http/http.dart' as http;

class APIHelper {
  String base_url = 'http://192.168.88.253:8000';
  Map<String, String> header = {
    'Content-Type': 'application/json; charset=UTF-8'
  };
  Map<String, String> header2 = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Token ${UserAuth.Token}'
  };
  Future<http.Response?> get({required String path, int? Header}) async {
    http.Response responce;
    var url = Uri.parse("$base_url$path");
    responce = await http.get(url, headers: Header == 1 ? header : header2);

    return responce;
  }

  Future<http.Response?> post(
      {required String path, required Object body, required int Header}) async {
    http.Response? responce;
    try {
      var url = Uri.parse("$base_url$path");
      print(json.encode(body));

      responce = await http.post(url,
          headers: Header == 1 ? header : header2, body: json.encode(body));

      return responce;
    } catch (e) {
      print(e);
    }
    return responce;
  }

  Future<http.Response?> put(
      {required String path, required Object body, required int Header}) async {
    http.Response? responce;
    try {
      var url = Uri.parse("$base_url$path");

      responce = await http.put(url,
          headers: Header == 1 ? header : header2, body: json.encode(body));

      return responce;
    } catch (e) {
      print(e);
    }
    return responce;
  }

  Future<http.Response?> delete(
      {required String path, required int Header}) async {
    http.Response? responce;
    try {
      var url = Uri.parse("$base_url$path");

      responce =
          await http.delete(url, headers: Header == 1 ? header : header2);

      return responce;
    } catch (e) {
      print(e);
    }
    return responce;
  }
}
