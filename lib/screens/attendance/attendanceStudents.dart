import 'package:schoolattendance/bloc/attendancebloc/attendance_bloc.dart';
import 'package:schoolattendance/repository/API/LocalServerAPI/APIdate/APIattendance.dart';
import 'package:schoolattendance/repository/auth/userAuth.dart';
import 'package:schoolattendance/services/models/attendance.dart';
import 'package:schoolattendance/services/models/lesson.dart';
import 'package:schoolattendance/services/models/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../bloc/studentbloc/student_bloc.dart';
import '../../widgets/cbackbutton.dart';

class AttendanceStudentsScreen extends StatefulWidget {
  String clas;
  LessonModel Lesson;
  AttendanceStudentsScreen({required this.Lesson, required this.clas});

  @override
  State<AttendanceStudentsScreen> createState() =>
      _AttendanceStudentsScreenState();
}

class _AttendanceStudentsScreenState extends State<AttendanceStudentsScreen> {
  List<AttendanceModel> AttendanceList = [];
  List<AttendanceModel> AttendanceListTmp = [];
  int Acount = 0;
  int Abcount = 0;
  bool is_edited = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<StudentBloc>()..add(AllStudentEvent());
    refrish();
  }

  refrish() {
    getAttendance();
    Future.delayed(Duration(seconds: 1)).whenComplete(() => setState(
          () {},
        ));
  }

  getAttendance() async {
    APIAttendance apiAttendance = APIAttendance();
    var a = await apiAttendance.getAttendance();
    var dt = DateTime.now();
    String d = "${dt.day}/${dt.month}/${dt.year}";

    AttendanceList = a
        .where((e) =>
            e.datetime == d &&
            e.lessonId == widget.Lesson.id &&
            e.clas == widget.clas)
        .toList();
    AttendanceListTmp = a
        .where((e) =>
            e.datetime == d &&
            e.lessonId == widget.Lesson.id &&
            e.clas == widget.clas)
        .toList();

    setState(() {});
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
                      "Attendance Screen",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: !is_edited
                          ? () {}
                          : AttendanceListTmp == AttendanceList
                              ? () {
                                  print("nt");
                                }
                              : () async {
                                  //ad
                                  APIAttendance apiAttendance = APIAttendance();
                                  print(AttendanceList);
                                  print(AttendanceListTmp);
                                  print("strt");

                                  AttendanceList.forEach((a) {
                                    if (AttendanceListTmp.contains(a)) {
                                      print("nothing");
                                    } else {
                                      print(a.studentName);
                                      context.read<AttendanceBloc>()
                                        ..add(
                                            AddAttendanceEvent(Attendance: a));
                                    }
                                  });
                                  AttendanceListTmp.forEach((a) {
                                    if (AttendanceList.contains(a)) {
                                      print("nothing");
                                    } else {
                                      print("del");
                                      context.read<AttendanceBloc>()
                                        ..add(DeleteAttendanceEvent(
                                            Attendance: a));
                                    }
                                  });
                                  context.read<AttendanceBloc>()
                                    ..add(AllAttendanceEvent());
                                  AttendanceListTmp = AttendanceList;
                                },
                      child: FaIcon(
                        FontAwesomeIcons.check,
                        color: is_edited ? Color(0xFF5f4a95) : Colors.grey,
                      )),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            //bottun
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.userSlash,
                                color: Colors.red,
                              ),
                              Text(
                                "$Abcount",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.user,
                                color: Colors.green,
                              ),
                              Text(
                                "$Acount",
                                style: TextStyle(
                                    color: Colors.green, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    BlocBuilder<StudentBloc, StudentState>(
                      builder: (context, state) {
                        if (state is LoadedStudentState) {
                          List<StudentModel> students =
                              state.StudentsList.where((e) =>
                                  e.stage == widget.Lesson.stage &&
                                  e.clas == widget.clas).toList();
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: students.length,
                            itemBuilder: (context, index) {
                              if (students.isEmpty) {
                                return Text("");
                              } else {
                                var student = students[index];
                                Acount = students.length - Abcount;
                                AttendanceList.forEach((e) {
                                  if (e.studentId == student.id) {
                                    student.is_Absence = true;
                                    Abcount = AttendanceList.length;
                                    Acount = students.length - Abcount;
                                  }
                                });
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      is_edited = true;
                                      if (student.is_Absence == true) {
                                        student.is_Absence = false;
                                        var a = AttendanceList.where(
                                            (e) => e.studentId == student.id);
                                        AttendanceList.remove(a.first);
                                        Abcount = AttendanceList.length;
                                        Acount = students.length - Abcount;
                                      } else {
                                        student.is_Absence = true;
                                        AttendanceModel attendance =
                                            AttendanceModel(
                                                studentId: student.id,
                                                datetime:
                                                    "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                                teacherName: "ahmed",
                                                studentName:
                                                    student.studentName,
                                                lessonId: widget.Lesson.id,
                                                clas: widget.clas);
                                        AttendanceList.add(attendance);
                                        Abcount = AttendanceList.length;
                                        Acount = students.length - Abcount;
                                      }
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 80,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: student.is_Absence ==
                                                            true
                                                        ? Colors.red
                                                        : Colors.green,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(15),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    15))),
                                              )),
                                          Expanded(
                                              flex: 40,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "${student.studentName}",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 5,
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
                                  ),
                                );
                              }
                            },
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
