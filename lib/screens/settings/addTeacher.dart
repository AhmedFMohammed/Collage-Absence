import 'package:schoolattendance/repository/API/LocalServerAPI/APIdate/APITeacher.dart';
import 'package:schoolattendance/screens/Stages/AddLesson.dart';
import 'package:schoolattendance/services/models/teacher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/cbackbutton.dart';

class AddTeacher extends StatefulWidget {
  const AddTeacher({super.key});

  @override
  State<AddTeacher> createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          //header
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CBackButton(
                      fnk: () => Navigator.pop(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async {
                          APITeacher _apiTeacher = APITeacher();

                          TeacherModel teacher = TeacherModel(
                            email: emailController.text,
                            firstName: firstnameController.text,
                            lastName: lastnameController.text,
                            username: usernameController.text,
                            password: passwordController.text,
                            password2: password2Controller.text,
                          );
                          await _apiTeacher.AddTeacher(teacher);
                          Navigator.pop(context);
                        },
                        child: FaIcon(
                          FontAwesomeIcons.check,
                          color: Color(0xFF5f4a95),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          //footer
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: firstnameController,
                            hint: "FirstName",
                          ),
                        ),
                        Expanded(
                          child: CustomTextField(
                            controller: lastnameController,
                            hint: "LastName",
                          ),
                        ),
                      ],
                    ),
                    CustomTextField(
                      controller: usernameController,
                      hint: "Username",
                    ),
                    CustomTextField(
                      controller: emailController,
                      hint: "Email",
                    ),
                    CustomTextField(
                      controller: passwordController,
                      hint: "Password",
                    ),
                    CustomTextField(
                      controller: password2Controller,
                      hint: "Verify Password",
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
