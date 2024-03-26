import 'dart:convert';

import 'package:schoolattendance/repository/API/LocalServerAPI/APIBASE.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/models/user.dart';

class UserAuth {
  APIHelper _apiHelper = APIHelper();
  static String Token = "";
  static bool role = true;

  Future getToken(String username, String password) async {
    try {
      Response? response = await _apiHelper.post(
          path: "/accounts/api-token-auth",
          body: {"username": "$username", "password": "$password"},
          Header: 1);

      var a = jsonDecode(response!.body);

      Token = a['token'];
      role = a['role'];

      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString("token", "$Token");
      sharedPreferences.setInt("user_id", a['user_id']);
    } catch (e) {
      return e;
    }
  }

  Future<UserModel> getUserInfo() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    int? id = sharedPreferences.getInt('user_id');

    Response? response2 =
        await _apiHelper.get(path: "/accounts/user/$id", Header: 1);
    Response? response =
        await _apiHelper.get(path: "/accounts/user/profile/$id", Header: 1);
    UserModel user;

    ProfileModel prof;
    user = await UserModel.fromJson(json.decode(response2!.body));
    prof = await ProfileModel.fromJson(json.decode(response!.body));
    user.profilePicture = prof.profilePicture;
    user.speciality = prof.speciality;

    return user;
  }
}
