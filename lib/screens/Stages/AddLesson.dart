import 'dart:convert';

import 'package:schoolattendance/bloc/lessonbloc/lesson_bloc.dart';
import 'package:schoolattendance/services/models/lesson.dart';
import 'package:schoolattendance/services/models/stage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/cbackbutton.dart';

class AddLesson extends StatefulWidget {
  String? simester;
  StageModel? stage;
  LessonModel? lesson;
  AddLesson({this.simester, this.lesson, this.stage});
  @override
  State<AddLesson> createState() => _AddLessonState();
}

class _AddLessonState extends State<AddLesson> {
  bool _SearchVisible = false;
  bool _selected = false;
  int ColorID = 0;

  // Controllers
  TextEditingController LessonNameController = TextEditingController();
  TextEditingController HourController = TextEditingController();
  TextEditingController MinuteController = TextEditingController();
  TextEditingController TeacherNameController = TextEditingController();

  // days
  TextEditingController sun = new TextEditingController(text: "not");
  TextEditingController mon = new TextEditingController(text: "not");
  TextEditingController tue = new TextEditingController(text: "not");
  TextEditingController wed = new TextEditingController(text: "not");
  TextEditingController thu = new TextEditingController(text: "not");
  TextEditingController fri = new TextEditingController(text: "not");
  TextEditingController sat = new TextEditingController(text: "not");

  bool am = true;
  int? idt;

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
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.lesson != null) {
      widget.simester = widget.lesson?.semester as String;
      LessonNameController.text = widget.lesson?.lessonName as String;

      var t = widget.lesson?.time?.split("|").toList();
      idt = int.parse(t![1]);
      var time = t[0].split(":").toList();
      time[0] = time[0].replaceAll(RegExp(r"\s+"), "") as String;
      time[1] = time[1].replaceAll(RegExp(r"\s+"), "") as String;
      if (int.parse(time[0]) > 12) {
        HourController.text = "${int.parse(time[0]) - 12}";
        am = false;
      } else {
        HourController.text = "${time[0]}";
      }

      MinuteController.text = "${time[1]}";
      TeacherNameController.text = widget.lesson?.teacherName as String;
      ColorID = int.parse(widget.lesson?.color as String);
      var days = widget.lesson?.days?.split(",").toList();

      for (var i in days!) {
        switch (i) {
          case "Sun":
            sun.text = i;
            break;
          case "Mon":
            mon.text = i;
            break;
          case "Tue":
            tue.text = i;
            break;
          case "Wed":
            wed.text = i;
            break;
          case "Thu":
            thu.text = i;
            break;
          case "Fri":
            fri.text = i;
            break;
          case "Sat":
            sat.text = i;
            break;
          default:
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
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
                    Visibility(
                      visible: widget.lesson != null,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            context.read<LessonBloc>()
                              ..add(DeleteLessonEvent(
                                  lesson: widget.lesson as LessonModel));
                            context.read<LessonBloc>()..add(AllLessonEvent());
                            Navigator.pop(context);
                          },
                          child: FaIcon(
                            FontAwesomeIcons.trash,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: FaIcon(
                          FontAwesomeIcons.check,
                          color: Color(0xFF5f4a95),
                        ),
                        onTap: () {
                          String days = "";
                          List dayS = [sun, mon, tue, wed, thu, fri, sat];
                          dayS = List.from(dayS.where((e) => e.text != "not"));
                          for (var i in dayS) {
                            if (i.text == "not") {
                            } else {
                              if (i == dayS.last) {
                                days += "${i.text}";
                              } else {
                                days += "${i.text},";
                              }
                            }
                          }

                          if (!am) {
                            var tmp = int.parse(HourController.text);

                            HourController.text = "${tmp + 12}";
                          }
                          DateTime dtn = DateTime.now();
                          DateTime dt;
                          if (idt == null) {
                            dt = DateTime(
                                dtn.year,
                                dtn.month,
                                dtn.day,
                                int.parse(HourController.text),
                                int.parse(MinuteController.text));
                            print(dt);
                          } else {
                            var tdt = DateTime.fromMillisecondsSinceEpoch(
                              idt!,
                            );
                            dt = DateTime(
                                tdt.year,
                                tdt.month,
                                tdt.day,
                                int.parse(HourController.text),
                                int.parse(MinuteController.text));
                            print(tdt);
                          }

                          LessonModel lesson = LessonModel(
                            color: "$ColorID",
                            lessonName: LessonNameController.text,
                            teacherName: TeacherNameController.text,
                            time:
                                "${HourController.text} : ${MinuteController.text}|${dt.millisecondsSinceEpoch}",
                            semester: widget.lesson != null
                                ? "${widget.lesson?.semester}"
                                : widget.simester,
                            comment: " ",
                            days: days,
                            stage: widget.lesson != null
                                ? "${widget.lesson?.stage}"
                                : "${widget.stage?.id}",
                          );
                          // real actiom
                          if (widget.lesson == null) {
                            context
                                .read<LessonBloc>()
                                .add(AddLessonEvent(lesson: lesson));
                          } else {
                            lesson.id = widget.lesson?.id;
                            context
                                .read<LessonBloc>()
                                .add(EditLessonEvent(lesson: lesson));
                            context.read<LessonBloc>()..add(AllLessonEvent());
                          }

                          context.read<LessonBloc>()..add(AllLessonEvent());
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      controller: LessonNameController,
                      hint: "Lesson Name ",
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          DateDays("Sun", sun),
                          DateDays("Mon", mon),
                          DateDays("Tue", tue),
                          DateDays("Wed", wed),
                          DateDays("Thu", thu),
                          DateDays("Fri", fri),
                          DateDays("Sat", sat),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: CustomTextField(
                            controller: HourController,
                            hint: "hour",
                            keyType: TextInputType.number,
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: CustomTextField(
                            controller: MinuteController,
                            hint: "Minute",
                            keyType: TextInputType.number,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              am = !am;
                            });
                          },
                          child: Text(
                            am ? "AM" : "PM",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    CustomTextField(
                      controller: TeacherNameController,
                      hint: "Teacher Name ",
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 40,
                        child: ListView.builder(
                            itemCount: colors.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              return Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: CircleAvatar(
                                  backgroundColor: ColorID == i
                                      ? Color(0xFF5f4a95)
                                      : Colors.transparent,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        ColorID = i;
                                      });
                                    },
                                    child: CircleAvatar(
                                      maxRadius: 16,
                                      backgroundColor: colors.elementAt(i),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}

class CustomTextField extends StatelessWidget {
  String? hint;
  TextInputType keyType;
  int maxLine;
  bool readOnly, ot;
  void Function(String)? onChanged;
  Widget? sufex;
  TextEditingController? controller = new TextEditingController();
  CustomTextField({
    this.hint,
    this.sufex,
    this.keyType = TextInputType.text,
    this.maxLine = 1,
    this.onChanged,
    this.controller,
    this.readOnly = false,
    this.ot = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        obscureText: ot,
        controller: controller,
        onChanged: onChanged,
        maxLines: maxLine,
        minLines: 1,
        readOnly: readOnly,
        keyboardType: keyType,
        decoration: InputDecoration(
          suffix: sufex,
          label: Text("$hint"),
          hintText: '$hint',
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(width: 1, color: Colors.black)),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class DateDays extends StatefulWidget {
  String Day;
  TextEditingController controller;
  DateDays(this.Day, this.controller);

  @override
  State<DateDays> createState() => _DateDaysState();
}

class _DateDaysState extends State<DateDays> {
  bool h = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (widget.controller.text == widget.Day) {
              widget.controller.text = "not";
            } else {
              widget.controller.text = widget.Day;
            }
          });
        },
        child: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF5f4a95),
                  spreadRadius: 0.1,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              color: widget.controller.text == "not"
                  ? Color.fromARGB(255, 144, 124, 193)
                  : Color(0xFF5f4a95),
              borderRadius: BorderRadius.circular(100)),
          child: Center(
            child: Text(
              widget.Day,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
