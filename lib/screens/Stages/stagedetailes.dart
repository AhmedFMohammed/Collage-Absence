import 'package:schoolattendance/bloc/lessonbloc/lesson_bloc.dart';
import 'package:schoolattendance/repository/auth/userAuth.dart';
import 'package:schoolattendance/screens/Stages/AddLesson.dart';
import 'package:schoolattendance/screens/Stages/StageLessons.dart';
import 'package:schoolattendance/services/models/lesson.dart';
import 'package:schoolattendance/services/models/stage.dart';
import 'package:schoolattendance/widgets/cbackbutton.dart';
import 'package:schoolattendance/widgets/ccardWithLine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../bloc/studentbloc/student_bloc.dart';
import '../../repository/API/LocalServerAPI/APIdate/APIstage.dart';

class StageDetailes extends StatefulWidget {
  StageModel stage;
  StageDetailes({required this.stage});

  @override
  State<StageDetailes> createState() => _StageDetailesState();
}

class _StageDetailesState extends State<StageDetailes> {
  bool? is_Semester1 = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<LessonBloc>()..add(AllLessonEvent());
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
                      "Stage ${widget.stage.id}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ],
                ),
                Visibility(
                  visible: UserAuth.role,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddLesson(
                                  stage: widget.stage,
                                  simester:
                                      is_Semester1 == true ? "one" : "two"),
                            )),
                        child: FaIcon(
                          FontAwesomeIcons.plus,
                          color: Color(0xFF5f4a95),
                        )),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),

            //buttom
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (states) => is_Semester1 == true
                                            ? Color(0xFF5f4a95)
                                            : Colors.white),
                                shape: MaterialStateProperty.resolveWith<
                                    OutlinedBorder>(
                                  (states) => RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: is_Semester1 == false
                                            ? Color(0xFF5f4a95)
                                            : Colors.transparent),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  is_Semester1 = true;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Semester 1",
                                  style: TextStyle(
                                      color: is_Semester1 == false
                                          ? Color(0xFF5f4a95)
                                          : Colors.white),
                                ),
                              )),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (states) => is_Semester1 == false
                                            ? Color(0xFF5f4a95)
                                            : Colors.white),
                                shape: MaterialStateProperty.resolveWith<
                                    OutlinedBorder>(
                                  (states) => RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: is_Semester1 == true
                                            ? Color(0xFF5f4a95)
                                            : Colors.transparent),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  is_Semester1 = false;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Semester 2",
                                  style: TextStyle(
                                      color: is_Semester1 == true
                                          ? Color(0xFF5f4a95)
                                          : Colors.white),
                                ),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ListLessonsView(
                          stage: widget.stage,
                          semester: is_Semester1 == true ? "one" : "two",
                          is_Schedule: false),
                    ],
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

class ListLessonsView extends StatefulWidget {
  StageModel? stage;
  String? semester, day;
  bool? is_Schedule, is_Attendance;

  ListLessonsView(
      {this.stage,
      this.semester,
      this.is_Schedule,
      this.day,
      this.is_Attendance});

  @override
  State<ListLessonsView> createState() => _ListLessonsViewState();
}

class _ListLessonsViewState extends State<ListLessonsView> {
  APIStage apiStage = APIStage();

  List<StageModel> stages = [];
  bool is_owner = UserAuth.role;

  @override
  void initState() {
    super.initState();
    getStages();
  }

  Future<void> getStages() async {
    stages = await apiStage.getStages();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<LessonBloc, LessonState>(
          builder: (context, state) {
            if (state is LoadedLessonState && stages.isNotEmpty) {
              List<LessonModel> LessonsList = [];
              if (widget.is_Schedule == true) {
                LessonsList = List.from(state.LessonsList.where(
                  (e) => e.days!.contains("${widget.day}") as bool,
                ));
                LessonsList.sort(
                  (a, b) {
                    var t = a.time?.split("|");
                    var t2 = b.time?.split("|");
                    return t![1].compareTo(t2![1]);
                  },
                );
              } else if (widget.is_Attendance == true) {
                LessonsList = state.LessonsList;
                LessonsList.sort(
                  (a, b) {
                    var t = a.time?.split("|");
                    var t2 = b.time?.split("|");
                    return t![1].compareTo(t2![1]);
                  },
                );
              } else {
                LessonsList = List.from(state.LessonsList.where((e) =>
                    e.semester == widget.semester &&
                    e.stage == "${widget.stage?.id}"));
                LessonsList.sort(
                  (a, b) {
                    var t = a.time?.split("|");
                    var t2 = b.time?.split("|");
                    return t![1].compareTo(t2![1]);
                  },
                );
              }
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: LessonsList.length,
                itemBuilder: (context, index) {
                  var lesson = LessonsList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Slidable(
                      endActionPane: !is_owner
                          ? null
                          : ActionPane(
                              motion: const ScrollMotion(),
                              extentRatio: 1 / 2.5,
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    context.read<LessonBloc>()
                                      ..add(DeleteLessonEvent(lesson: lesson));
                                    context.read<LessonBloc>()
                                      ..add(AllLessonEvent());
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
                                          builder: (context) => AddLesson(
                                            lesson: lesson,
                                          ),
                                        ));
                                  },
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Color(0xFF5f4a95),
                                  icon: FontAwesomeIcons.pen,
                                  label: 'Edit',
                                ),
                              ],
                            ),
                      child: GestureDetector(
                        onDoubleTap: () {
                          widget.is_Schedule == false
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddLesson(
                                      stage: widget.stage!,
                                      simester: widget.semester!,
                                      lesson: lesson,
                                    ),
                                  ))
                              : null;
                        },
                        child: CCardWithLine(
                          is_Attendance: widget.is_Attendance,
                          lesson: lesson,
                          stage: stages[int.parse(lesson.stage as String) - 1],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
