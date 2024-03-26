import 'package:schoolattendance/repository/API/LocalServerAPI/APIdate/APIlesson.dart';
import 'package:schoolattendance/screens/Stages/AddLesson.dart';
import 'package:schoolattendance/services/models/lesson.dart';
import 'package:schoolattendance/services/models/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/attendancebloc/attendance_bloc.dart';
import '../../widgets/cbackbutton.dart';

class StudentProfile extends StatefulWidget {
  StudentModel student;
  StudentProfile(this.student);

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  TextEditingController nameC = TextEditingController();
  List<LessonModel> LessonList = [];
  bool is_Slected1 = false;
  bool is_Slected2 = false;
  bool is_Slected3 = false;
  bool is_Slected4 = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AttendanceBloc>()..add(AllAttendanceEvent());
    getLissons();
    SelectStage(widget.student.stage);
    print(widget.student.stage);
    nameC.text = widget.student.studentName as String;
  }

  SelectStage(String? stage) {
    is_Slected1 = false;
    is_Slected2 = false;
    is_Slected3 = false;
    is_Slected4 = false;
    setState(() {
      if (stage == "1") {
        is_Slected1 = true;
      } else if (stage == "2") {
        is_Slected2 = true;
      } else if (stage == "3") {
        is_Slected3 = true;
      } else if (stage == "4") {
        is_Slected4 = true;
      }
    });
  }

  getLissons() async {
    APILesson _lesson = APILesson();

    LessonList = await _lesson.getLesson();
    LessonList = LessonList.where(
      (e) => e.stage == widget.student.stage,
    ).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                      Column(
                        children: [
                          CustomTextField(
                            controller: nameC,
                            hint: "Name",
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ChoiceChip(
                                label: Text(
                                  "Stage1",
                                  style: TextStyle(
                                      color: is_Slected1
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                selected: is_Slected1,
                                selectedColor: Color(0xFF5f4a95),
                                onSelected: (value) {
                                  SelectStage("1");
                                },
                              ),
                              ChoiceChip(
                                label: Text(
                                  "Stage2",
                                  style: TextStyle(
                                      color: is_Slected2
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                selected: is_Slected2,
                                selectedColor: Color(0xFF5f4a95),
                                onSelected: (value) {
                                  SelectStage("2");
                                },
                              ),
                              ChoiceChip(
                                label: Text(
                                  "Stage3",
                                  style: TextStyle(
                                      color: is_Slected3
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                selected: is_Slected3,
                                selectedColor: Color(0xFF5f4a95),
                                onSelected: (value) {
                                  SelectStage("3");
                                },
                              ),
                              ChoiceChip(
                                label: Text(
                                  "Stage4",
                                  style: TextStyle(
                                      color: is_Slected4
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                selected: is_Slected4,
                                selectedColor: Color(0xFF5f4a95),
                                onSelected: (value) {
                                  SelectStage("4");
                                },
                              ),
                            ],
                          ),
                          ListOfLessons(LessonList),
                          AttendanceList(LessonList),
                        ],
                      ),
                    ]),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}

class ListOfLessons extends StatefulWidget {
  List<LessonModel> list = [];
  ListOfLessons(this.list);

  @override
  State<ListOfLessons> createState() => _ListOfLessonsState();
}

class _ListOfLessonsState extends State<ListOfLessons> {
  bool is_Slected = true;

  List<bool> lb = [];

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < widget.list.length; i++) {
      lb.add(false);
    }
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.list.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var lesson = widget.list[index];
          if (widget.list.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ChoiceChip(
                label: Text(
                  "${lesson.lessonName}",
                  style:
                      TextStyle(color: lb[index] ? Colors.white : Colors.black),
                ),
                selected: lb[index],
                selectedColor: Color(0xFF5f4a95),
                disabledColor: Colors.grey,
                onSelected: (value) {
                  setState(() {
                    for (var i = 0; i < lb.length; i++) {
                      if (i == index) {
                        lb[i] = value;
                      } else {
                        lb[i] = false;
                      }
                    }
                    if (value == false) {
                      context.read<AttendanceBloc>()..add(AllAttendanceEvent());
                    } else {
                      context.read<AttendanceBloc>()
                        ..add(FilterAttendanceEvent(lesson: lesson.id as int));
                    }
                  });
                },
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class AttendanceList extends StatefulWidget {
  List<LessonModel> LessonList = [];
  AttendanceList(this.LessonList);

  @override
  State<AttendanceList> createState() => _AttendanceListState();
}

class _AttendanceListState extends State<AttendanceList> {
  @override
  Widget build(BuildContext context) {
    var LessonList = widget.LessonList;
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        if (state is LoadedAttendanceState && LessonList.isNotEmpty) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.AttendanceList.length,
            itemBuilder: (context, index) {
              var attend = state.AttendanceList[index];
              var lesson = LessonList.where(
                (e) => e.id == attend.lessonId,
              );
              print(attend.lessonId);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    title: Text(
                      "${lesson.first.lessonName}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text("${attend.datetime}"),
                    subtitle: Text("${attend.teacherName}"),
                  ),
                ),
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
