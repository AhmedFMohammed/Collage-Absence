import 'package:schoolattendance/repository/API/LocalServerAPI/APIdate/APIstage.dart';
import 'package:schoolattendance/screens/Stages/StageLessons.dart';
import 'package:schoolattendance/services/models/stage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/cbackbutton.dart';
import '../settings/students.dart';

class EditStage extends StatefulWidget {
  StageModel stage;
  EditStage(this.stage);

  @override
  State<EditStage> createState() => _EditStageState();
}

class _EditStageState extends State<EditStage> {
  TextEditingController searchController = TextEditingController();
  APIStage _apiStage = APIStage();
  bool is_Active = true;
  bool is_EditMode = false;
  bool is_search = false;

  bool is_Aactive = false;
  bool is_Bactive = false;
  bool is_Cactive = false;
  bool is_Dactive = false;
  bool is_next = false;
  bool is_pre = false;
  int index = 0;
  List<String> listofClasses = [];

  @override
  void initState() {
    is_Active = widget.stage.is_Activated as bool;
    String s = widget.stage.classes as String;
    if (s.contains(',')) {
      var a = s.split("");
      List<String> parts = [];
      for (var i = 0; i < a.length; i++) {
        if (s[i] == ",") {
        } else {
          parts.add(s[i]);
        }
      }
      parts.forEach((e) {
        classActivator(e);
        angelfunc(e);
      });
      print(listofClasses);
    } else {
      listofClasses.add(widget.stage.classes as String);
      classActivator(widget.stage.classes as String);
    }

    // TODO: implement initState
    super.initState();
  }

  classActivator(String s) {
    s = s.replaceAll(" ", "");
    setState(() {
      switch (s) {
        case "A":
          is_Aactive = true;
          break;
        case "B":
          is_Bactive = true;
          break;
        case "C":
          is_Cactive = true;
          break;
        case "D":
          is_Dactive = true;
          break;
      }
    });
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
                      child: CBackButton(
                        fnk: is_EditMode ? null : () => Navigator.pop(context),
                        color: is_EditMode
                            ? Colors.grey.shade400
                            : Color(0xFF5f4a95),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Edit Stage",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      setState(() {
                        is_EditMode = !is_EditMode;
                      });
                      var stage = widget.stage;
                      String classes = "";
                      listofClasses.forEach((e) {
                        if (e == listofClasses.last) {
                          classes += "$e";
                        } else {
                          classes += "$e,";
                        }
                      });
                      stage.classes = classes;
                      stage.is_Activated = is_Active;
                      stage.classes_count = listofClasses.length;
                      stage.semester = "one";
                      await _apiStage.updateStage(stage);
                    },
                    child: FaIcon(
                      is_EditMode == false ? null : FontAwesomeIcons.check,
                      color: Color(0xFF5f4a95),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),

            //buttom
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (states) => is_Active == true
                                        ? Color(0xFF5f4a95)
                                        : Colors.white),
                            shape: MaterialStateProperty.resolveWith<
                                OutlinedBorder>(
                              (states) => RoundedRectangleBorder(
                                side: BorderSide(
                                    color: is_Active == true
                                        ? Colors.transparent
                                        : Colors.red),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              is_Active = !is_Active;
                              is_EditMode = true;
                            });
                          },
                          child: Text(
                            is_Active == true ? "Activated" : "Deactivated",
                            style: TextStyle(
                                color: is_Active ? Colors.white : Colors.red),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Classes :",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  TextBtn(
                                    fnk: () {
                                      setState(() {
                                        if (listofClasses.length == 1) {
                                          angelfunc("A");
                                          is_Aactive = true;
                                          is_EditMode = true;
                                        } else {
                                          angelfunc("A");
                                          is_Aactive = !is_Aactive;
                                          is_EditMode = true;
                                        }
                                      });
                                    },
                                    text: "A",
                                    color:
                                        is_Aactive ? Colors.black : Colors.grey,
                                  ),
                                  TextBtn(
                                    fnk: () {
                                      setState(() {
                                        if (listofClasses.length == 1) {
                                          angelfunc("B");
                                          is_Bactive = true;
                                          is_EditMode = true;
                                        } else {
                                          angelfunc("B");
                                          is_Bactive = !is_Bactive;
                                          is_EditMode = true;
                                        }
                                      });
                                    },
                                    text: "B",
                                    color:
                                        is_Bactive ? Colors.black : Colors.grey,
                                  ),
                                  TextBtn(
                                    fnk: () {
                                      setState(() {
                                        if (listofClasses.length == 1) {
                                          angelfunc("C");
                                          is_Cactive = true;
                                          is_EditMode = true;
                                        } else {
                                          angelfunc("C");
                                          is_Cactive = !is_Cactive;
                                          is_EditMode = true;
                                        }
                                      });
                                      listofClasses.sort();
                                    },
                                    text: "C",
                                    color:
                                        is_Cactive ? Colors.black : Colors.grey,
                                  ),
                                  TextBtn(
                                    fnk: () {
                                      setState(() {
                                        if (listofClasses.length > 1) {
                                          if (listofClasses.length == 1) {
                                            angelfunc("D");
                                            is_Dactive = true;
                                            is_EditMode = true;
                                          } else {
                                            angelfunc("D");
                                            is_Dactive = !is_Dactive;
                                            is_EditMode = true;
                                          }
                                        }
                                      });
                                    },
                                    text: "D",
                                    color:
                                        is_Dactive ? Colors.black : Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            //mixed

                            Row(
                              children: [
                                Visibility(
                                  visible: !is_search,
                                  child: Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF5f4a95),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: is_pre
                                                      ? () {
                                                          setState(() {
                                                            if (listofClasses
                                                                    .isNotEmpty &&
                                                                listofClasses
                                                                        .first !=
                                                                    "${listofClasses[index]}") {
                                                              index--;
                                                              is_next = true;
                                                              is_pre = true;
                                                            }
                                                            if (listofClasses
                                                                    .first ==
                                                                "${listofClasses[index]}") {
                                                              is_next = true;
                                                              is_pre = false;
                                                            }
                                                          });
                                                        }
                                                      : null,
                                                  child: FaIcon(
                                                    FontAwesomeIcons.angleLeft,
                                                    color: is_pre
                                                        ? Colors.white
                                                        : Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              TextBtn2(
                                                fnk: () {},
                                                text: listofClasses.isEmpty
                                                    ? " "
                                                    : "${listofClasses[index]}",
                                                color: is_Aactive
                                                    ? Colors.black
                                                    : Colors.grey,
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: is_next
                                                      ? () {
                                                          setState(() {
                                                            if (listofClasses
                                                                    .isNotEmpty &&
                                                                listofClasses
                                                                        .last !=
                                                                    "${listofClasses[index]}") {
                                                              index++;
                                                              is_next = true;
                                                              is_pre = true;
                                                            }
                                                            if (listofClasses
                                                                    .last ==
                                                                "${listofClasses[index]}") {
                                                              is_next = false;
                                                              is_pre = true;
                                                            }
                                                          });
                                                        }
                                                      : null,
                                                  child: FaIcon(
                                                    FontAwesomeIcons.angleRight,
                                                    color: is_next
                                                        ? Colors.white
                                                        : Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: is_search,
                                  child: Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF5f4a95),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Center(
                                          child: TextField(
                                            controller: searchController,
                                            style:
                                                TextStyle(color: Colors.white),
                                            textAlign: TextAlign.start,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                right: 10,
                                                left: 10,
                                                bottom: 40 /
                                                    2, // HERE THE IMPORTANT PART
                                              ),
                                              hintText: "Enter Student Name: ",
                                              hintStyle: TextStyle(
                                                  color: Colors.white60),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 3,
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18)),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                borderSide: BorderSide(
                                                    width: 3,
                                                    color: Colors.white),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                borderSide: BorderSide(
                                                    width: 3,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        is_EditMode = true;
                                        is_search = !is_search;
                                      });
                                    },
                                    child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: Color(0xFF5f4a95),
                                            borderRadius:
                                                BorderRadius.circular(29)),
                                        child: Center(
                                            child: FaIcon(
                                          is_search
                                              ? FontAwesomeIcons.check
                                              : FontAwesomeIcons.plus,
                                          color: Colors.white,
                                        ))),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListStudent(
                              clas: listofClasses[index],
                              stage: widget.stage.id,
                              is_Search: is_search),
                        )
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

  angelfunc(String ang) {
    bool exist = false;

    listofClasses.forEach((e) {
      if (e == "$ang") exist = true;
    });

    if (exist && listofClasses.length > 1) {
      listofClasses.remove("$ang");
      index = 0;

      if (listofClasses.length == 1) {
        is_next = false;
        is_pre = false;
        index = 0;
      }

      if (index == 0 && listofClasses.length >= 2) {
        is_next = true;
        is_pre = false;
      }
      print(listofClasses);
    } else if (!exist) {
      listofClasses.add("$ang");
      index = 0;
      if (listofClasses.length == 1) {
        is_next = false;
        is_pre = false;
        index = 0;
      }

      if (index == 0 && listofClasses.length >= 2) {
        is_next = true;
        is_pre = false;
      }
      print(listofClasses);
    }
    setState(() {});
    listofClasses.sort();
  }
}

class TextBtn extends StatelessWidget {
  String text;
  Color? color;
  Function()? fnk;
  TextBtn({required this.text, this.color, this.fnk});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: fnk,
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: color, fontSize: 20),
        ),
      ),
    );
  }
}

class TextBtn2 extends StatelessWidget {
  String text;
  Color? color;
  Function()? fnk;
  TextBtn2({required this.text, this.color, this.fnk});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: fnk,
        child: Container(
          decoration: BoxDecoration(
            // border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(15),
            // boxShadow: [
            //   BoxShadow(
            //     color: Color.fromARGB(255, 170, 143, 239),
            //     blurRadius: 9,
            //     spreadRadius: 4,
            //   )
            // ],
          ),
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
