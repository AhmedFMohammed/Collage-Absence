import 'package:schoolattendance/repository/auth/userAuth.dart';
import 'package:schoolattendance/services/models/stage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../repository/API/LocalServerAPI/APIdate/APIstage.dart';
import '../widgets/cbackbutton.dart';
import '../widgets/stageCard.dart';
import 'Stages/EditStage.dart';
import 'Stages/stagedetailes.dart';

class StagesScreen extends StatefulWidget {
  @override
  State<StagesScreen> createState() => _StagesScreenState();
}

class _StagesScreenState extends State<StagesScreen> {
  bool is_EditMode = false;
  APIStage apiStage = APIStage();
  List<StageModel> stages = [];
  UserAuth userAuth = UserAuth();
  @override
  void initState() {
    // TODO: implement initState
    getStages();

    super.initState();
  }

  Future<void> getStages() async {
    stages = await apiStage.getStages();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              //header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CBackButton(
                          fnk:
                              is_EditMode ? null : () => Navigator.pop(context),
                          color: is_EditMode
                              ? Colors.grey.shade400
                              : Color(0xFF5f4a95),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Stages",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: UserAuth.role,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            is_EditMode = !is_EditMode;
                          });
                        },
                        child: FaIcon(
                          is_EditMode == false
                              ? FontAwesomeIcons.pen
                              : FontAwesomeIcons.check,
                          color: Color(0xFF5f4a95),
                        ),
                      ),
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
                        Visibility(
                          visible: stages.isEmpty
                              ? false
                              : is_EditMode
                                  ? is_EditMode
                                  : stages[0].is_Activated as bool,
                          child: StageCard(
                            icangle: is_EditMode == false
                                ? FontAwesomeIcons.angleRight
                                : FontAwesomeIcons.pen,
                            fnk: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => is_EditMode
                                        ? EditStage(stages[0])
                                        : StageDetailes(stage: stages[0]))),
                            Stage: "First Stage",
                            classes:
                                stages.isEmpty ? 0 : stages[0].classes_count,
                            ficd: FontAwesomeIcons.one,
                            students: stages.isEmpty
                                ? 0
                                : int.parse(stages[0].student_count as String),
                            color1: Color.fromARGB(255, 136, 131, 174),
                            color2: Color.fromARGB(255, 120, 112, 193),
                          ),
                        ),
                        Visibility(
                          visible: stages.isEmpty
                              ? false
                              : is_EditMode
                                  ? is_EditMode
                                  : stages[1].is_Activated as bool,
                          child: StageCard(
                            icangle: is_EditMode == false
                                ? FontAwesomeIcons.angleRight
                                : FontAwesomeIcons.pen,
                            fnk: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => is_EditMode
                                        ? EditStage(stages[1])
                                        : StageDetailes(stage: stages[1]))),
                            Stage: "Second Stage",
                            classes:
                                stages.isEmpty ? 0 : stages[1].classes_count,
                            ficd: FontAwesomeIcons.two,
                            students: stages.isEmpty
                                ? 0
                                : int.parse(stages[1].student_count as String),
                            color1: Color.fromARGB(255, 147, 131, 174),
                            color2: Color.fromARGB(255, 166, 112, 193),
                          ),
                        ),
                        Visibility(
                          visible: stages.isEmpty
                              ? false
                              : is_EditMode
                                  ? is_EditMode
                                  : stages[2].is_Activated as bool,
                          child: StageCard(
                            icangle: is_EditMode == false
                                ? FontAwesomeIcons.angleRight
                                : FontAwesomeIcons.pen,
                            fnk: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => is_EditMode
                                        ? EditStage(stages[2])
                                        : StageDetailes(stage: stages[2]))),
                            Stage: "Third Stage",
                            classes:
                                stages.isEmpty ? 0 : stages[2].classes_count,
                            ficd: FontAwesomeIcons.three,
                            students: stages.isEmpty
                                ? 0
                                : int.parse(stages[2].student_count as String),
                            color1: Color.fromARGB(255, 174, 131, 174),
                            color2: Color.fromARGB(255, 186, 112, 193),
                          ),
                        ),
                        Visibility(
                          visible: stages.isEmpty
                              ? false
                              : is_EditMode
                                  ? is_EditMode
                                  : stages[3].is_Activated as bool,
                          child: StageCard(
                            icangle: is_EditMode == false
                                ? FontAwesomeIcons.angleRight
                                : FontAwesomeIcons.pen,
                            fnk: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => is_EditMode
                                        ? EditStage(stages[3])
                                        : StageDetailes(
                                            stage: stages[3],
                                          ))),
                            Stage: "Fourth Stage",
                            classes:
                                stages.isEmpty ? 0 : stages[3].classes_count,
                            ficd: FontAwesomeIcons.four,
                            students: stages.isEmpty
                                ? 0
                                : int.parse(stages[3].student_count as String),
                            color1: Color.fromARGB(255, 174, 131, 155),
                            color2: Color.fromARGB(255, 193, 112, 142),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
