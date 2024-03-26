import 'package:schoolattendance/screens/settings/students.dart';
import 'package:schoolattendance/services/models/lesson.dart';
import 'package:schoolattendance/services/models/stage.dart';
import 'package:schoolattendance/services/models/student.dart';
import 'package:schoolattendance/widgets/cbackbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../bloc/studentbloc/student_bloc.dart';

class StageLessons extends StatefulWidget {
  LessonModel? lesson;
  StageModel? stage;
  String clas;
  bool? is_Attendance;
  StageLessons(
      {this.lesson, this.stage, required this.clas, this.is_Attendance});

  @override
  State<StageLessons> createState() => _StageLessonsState();
}

class _StageLessonsState extends State<StageLessons> {
  int iconint = 0, usericonint = 0;
  String? sort;

  Color icColor = Colors.black;
  TextEditingController stcount = TextEditingController(text: "0");
  List<IconData> sorticons = [
    FontAwesomeIcons.arrowDownAZ,
    FontAwesomeIcons.arrowUpAZ,
    FontAwesomeIcons.arrowUp,
    FontAwesomeIcons.arrowDown,
  ];
  List<IconData> sorticonsuser = [
    FontAwesomeIcons.user,
    FontAwesomeIcons.userSlash,
  ];

  @override
  void initState() {
    super.initState();
    refrish();
    setsort(iconint, usericonint);
  }

  refrish() {
    Future.delayed(Duration(seconds: 1)).whenComplete(() {
      setState(() {});
    });
  }

  setsort(int i, int ic) {
    if (ic == 0 && i == 0) {
      sort = "AZ";
    } else if (ic == 0 && i == 1) {
      sort = "ZA";
    } else if (ic == 1 && i == 2) {
      sort = "HA";
    } else if (ic == 1 && i == 3) {
      sort = "LA";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CBackButton(fnk: () => Navigator.pop(context)),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "${widget.lesson?.lessonName}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          FaIcon(FontAwesomeIcons.user),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "${stcount.text}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),

            //bottom
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (iconint == 3) {
                                      icColor = Colors.black;
                                      iconint = 0;
                                      usericonint = 0;
                                    } else if (iconint >= 1) {
                                      icColor = Colors.red;
                                      usericonint = 1;
                                      iconint = iconint + 1;
                                    } else {
                                      icColor = Colors.black;
                                      iconint = iconint + 1;
                                    }
                                    setsort(iconint, usericonint);
                                  });
                                },
                                child: Row(
                                  children: [
                                    FaIcon(
                                      sorticonsuser[usericonint],
                                      color: icColor,
                                    ),
                                    FaIcon(
                                      sorticons[iconint],
                                      color: icColor,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListStudent(
                          sortby: sort,
                          controller: stcount,
                          stage: int.parse("${widget.lesson?.stage}"),
                          clas: widget.clas,
                          is_Search: false,
                        ),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentsLessonList extends StatelessWidget {
  Color LineColor, icColor;
  List<StudentModel> students;
  StudentsLessonList(
      {this.LineColor = Colors.red,
      this.icColor = Colors.red,
      this.students = const []});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: students.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 80,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          color: LineColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15))),
                    )),
                Expanded(
                    flex: 40,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Student Name",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  FaIcon(FontAwesomeIcons.userSlash,
                                      color: icColor),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "5",
                                    style: TextStyle(
                                        color: icColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
