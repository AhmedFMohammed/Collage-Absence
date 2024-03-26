import 'package:schoolattendance/repository/API/LocalServerAPI/APIdate/APIstudent.dart';
import 'package:schoolattendance/screens/Stages/AddLesson.dart';
import 'package:schoolattendance/screens/Stages/StageLessons.dart';
import 'package:schoolattendance/screens/settings/teachers.dart';
import 'package:schoolattendance/screens/user/studentProfile.dart';
import 'package:schoolattendance/services/models/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../bloc/studentbloc/student_bloc.dart';
import '../../widgets/cbackbutton.dart';

class StudentsScreen extends StatefulWidget {
  StudentsScreen({Key? key}) : super(key: key);

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  TextEditingController nameController = TextEditingController();
  APIStudent _apiStudent = APIStudent();
  bool? is_Semester1 = true;
  List<StudentModel> students = [];
  int i = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<StudentBloc>()..add(AllStudentEvent());
  }

  getAttendanceCount() async {}

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
                      Row(
                        children: [
                          // CBackButton(
                          //   // fnk: () => Navigator.push(
                          //   //     context,
                          //   //     MaterialPageRoute(
                          //   //       builder: (context) => AttendanceList(),
                          //   //     )),
                          //   ICD: FontAwesomeIcons.listCheck,
                          // ),
                          SizedBox(
                            width: 10,
                          ),
                          CBackButton(
                            fnk: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TeacherScreen(),
                                )),
                            ICD: FontAwesomeIcons.chalkboardUser,
                          ),
                        ],
                      ),
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
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 30,
                          child: Center(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: 4,
                              itemBuilder: (context, index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: SizedBox(
                                  width: 80,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>((states) =>
                                              i == index
                                                  ? Color(0xFF5f4a95)
                                                  : Colors.white),
                                      shape: MaterialStateProperty.resolveWith<
                                          OutlinedBorder>(
                                        (states) => RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: i != index
                                                  ? Color(0xFF5f4a95)
                                                  : Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        i = index;
                                      });
                                    },
                                    child: Text(
                                      "stage ${index + 1}",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: i != index
                                              ? Color(0xFF5f4a95)
                                              : Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: nameController,
                                hint: "Enter Student Name",
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                StudentModel Student = StudentModel(
                                  studentName: nameController.text,
                                  stage: "${i + 1}",
                                  attendencecount: "0",
                                  clas: "A",
                                  comment: "",
                                );
                                context.read<StudentBloc>()
                                  ..add(AddStudentEvent(Student: Student));
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Color(0xFF5f4a95),
                                    borderRadius: BorderRadius.circular(29)),
                                child: Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.plus,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListStudent(
                          stage: i,
                          is_Search: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListStudent extends StatelessWidget {
  int? stage;
  String? clas, sortby;
  bool is_Search;
  TextEditingController? controller;

  ListStudent({
    this.stage,
    this.clas,
    this.sortby,
    required this.is_Search,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        if (state is LoadedStudentState) {
          List<StudentModel> students = [];

          if (!is_Search) {
            if (clas != null) {
              students = List.from(state.StudentsList.where(
                  (e) => e.clas == "${clas}" && e.stage == "${stage!}"));
            } else {
              students = List.from(
                  state.StudentsList.where((e) => e.stage == "${stage! + 1}"));
            }
          } else {
            students = List.from(
                state.StudentsList.where((e) => e.stage == "${stage!}"));
          }
          if (controller != null) {
            students = List.from(state.StudentsList.where(
                (e) => e.clas == "${clas}" && e.stage == "${stage!}"));
            controller?.text = "${students.length}";
          }

          return ListView.builder(
            itemCount: students.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (students.isEmpty) {
                return Text("");
              } else {
                var student = students[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 1 / 2.5,
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            context.read<StudentBloc>()
                              ..add(DeleteStudentEvent(Student: student));
                            context.read<StudentBloc>()..add(AllStudentEvent());
                          },
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.red,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                        SlidableAction(
                          onPressed: (context) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StudentProfile(student),
                                ));
                          },
                          backgroundColor: Colors.transparent,
                          foregroundColor: Color(0xFF5f4a95),
                          icon: FontAwesomeIcons.pen,
                          label: 'Edit',
                        ),
                      ],
                    ),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: is_Search
                                        ? ColorChanger(student.clas)
                                        : Colors.grey,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${student.studentName}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                if (is_Search) {
                                                  student.clas = clas;
                                                  context.read<StudentBloc>()
                                                    ..add(EditStudentEvent(
                                                        Student: student));
                                                  context.read<StudentBloc>()
                                                    ..add(AllStudentEvent());
                                                }
                                              },
                                              child: FaIcon(
                                                  !is_Search
                                                      ? FontAwesomeIcons
                                                          .userSlash
                                                      : FontAwesomeIcons.plus,
                                                  color: !is_Search
                                                      ? Colors.red
                                                      : Color(0xFF5f4a95)),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Visibility(
                                              visible: !is_Search,
                                              child: Text(
                                                "${student.attendencecount}",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
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
        return Container();
      },
    );
  }

  ColorChanger(String? clas) {
    int c = 0;
    List<Color> colors = [Colors.yellow, Colors.red, Colors.black, Colors.pink];
    switch (clas) {
      case "A":
        c = 0;
        break;
      case "B":
        c = 1;
        break;
      case "C":
        c = 2;
        break;
      case "D":
        c = 3;
        break;
      default:
    }

    return colors[c];
  }
}
