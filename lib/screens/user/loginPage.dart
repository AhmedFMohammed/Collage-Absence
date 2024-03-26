import 'package:schoolattendance/repository/auth/userAuth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repository/API/LocalServerAPI/APIBASE.dart';
import '../Stages/AddLesson.dart';
import '../homePage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool show = false;
  @override
  Widget build(BuildContext context) {
    double WIDTH = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Column(
              children: [
                Image.asset('assets/images/checkList.png'),
                Column(
                  children: [
                    CustomTextField(
                        controller: _usernameController, hint: "Username"),
                    CustomTextField(
                        sufex: GestureDetector(
                            onTap: () {
                              setState(() {
                                show = !show;
                              });
                            },
                            child: FaIcon(show
                                ? FontAwesomeIcons.eyeSlash
                                : FontAwesomeIcons.eye)),
                        ot: !show,
                        controller: _passwordController,
                        hint: "Password"),
                    SizedBox(
                      height: 100,
                    ),
                    GestureDetector(
                      onTap: () async {
                        var token;
                        final SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        UserAuth auth = UserAuth();
                        var a = await auth
                            .getToken(_usernameController.text,
                                _passwordController.text)
                            .whenComplete(() => {
                                  token = sharedPreferences.get("token"),
                                  if (token != null)
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyHomePage()),
                                        (route) => false)
                                });
                        if (a != null) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Login Error',
                            desc: 'Unable to log in with provided credentials.',
                            btnOkOnPress: () {},
                          ).show();
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Color(0xFF5F4A95)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(" "),
                                Text(
                                  "Login",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                FaIcon(FontAwesomeIcons.angleRight,
                                    color: Colors.white)
                              ]),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
