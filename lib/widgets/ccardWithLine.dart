import 'package:schoolattendance/screens/attendance/attendanceStudents.dart';
import 'package:schoolattendance/services/models/lesson.dart';
import 'package:schoolattendance/services/models/stage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/Stages/StageLessons.dart';

class CCardWithLine extends StatefulWidget {
  LessonModel? lesson;
  StageModel? stage;
  bool? is_Attendance;
  CCardWithLine({this.lesson, this.stage, this.is_Attendance});

  @override
  State<CCardWithLine> createState() => _CCardWithLineState();
}

class _CCardWithLineState extends State<CCardWithLine> {
  List<Color> colors = [
    Color(0xFFA9A1D2),
    Color(0xFFE8E84A),
    Color(0xFFAFDBDC),
    Color(0xFFD1E2D0),
    Color(0xFFE7CCC2),
    Color(0xFFE3947E),
    Color(0xFF0590A1),
    Color(0xFF405B14),
    Color(0xFF238552),
    Color(0xFF3B4E66),
    Color(0xFFC02C32),
    Color(0xFFF6A71E),
  ];

  @override
  Widget build(BuildContext context) {
    var lesson = widget.lesson;
    var t = widget.lesson?.time?.split("|");
    bool am = true;
    var time = t?[0].split(":");
    if (int.parse(time![0]) > 12) {
      time[0] = "${int.parse(time[0]) - 12}";
      am = false;
    }

    List s = List.from(widget.stage!.classes!.split(",").toList());
    return Container(
      height: 150,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
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
                    color: colors[int.parse(lesson?.color as String)],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15))),
              )),
          Expanded(
              flex: 40,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${lesson?.lessonName}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${lesson?.teacherName}",
                            style: TextStyle(
                              color: Color.fromARGB(195, 0, 0, 0),
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.clock,
                                color: Color.fromARGB(174, 3, 0, 0),
                                size: 18,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                am
                                    ? "${time[0]}:${time[1]} AM"
                                    : "${time[0]}:${time[1]} PM",
                                style: TextStyle(
                                    color: Color.fromARGB(174, 3, 0, 0),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Classes",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 25,
                                    width: 90,
                                    child: Center(
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: s.length,
                                        itemBuilder: (context, index) {
                                          IconData ic = FontAwesomeIcons.a;
                                          switch (s[index]) {
                                            case "A":
                                              ic = FontAwesomeIcons.a;
                                              break;
                                            case "B":
                                              ic = FontAwesomeIcons.b;
                                              break;
                                            case "C":
                                              ic = FontAwesomeIcons.c;
                                              break;
                                            case "D":
                                              ic = FontAwesomeIcons.d;
                                              break;
                                            default:
                                          }
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AttendanceStudentsScreen(
                                                                clas: s[index],
                                                                Lesson: widget
                                                                        .lesson
                                                                    as LessonModel,
                                                              )));
                                                },
                                                child: FaIcon(
                                                  ic,
                                                  size: 20,
                                                )),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
