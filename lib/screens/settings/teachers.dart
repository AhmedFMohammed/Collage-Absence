import 'dart:typed_data';

import 'package:schoolattendance/repository/API/LocalServerAPI/APIdate/APITeacher.dart';
import 'package:schoolattendance/screens/settings/addTeacher.dart';
import 'package:schoolattendance/services/models/profiles.dart';
import 'package:schoolattendance/services/models/teacher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../bloc/teacherbloc/teacher_bloc.dart';
import '../../widgets/cbackbutton.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({super.key});

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  List<Profile>? Tprofiles;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TeacherBloc>()..add(AllTeacherEvent());
    getProfiles();
  }

  getProfiles() async {
    APITeacher _apiTeacher = APITeacher();
    Tprofiles = await _apiTeacher.GetTeachersProfile();
    if (mounted) {
      setState(() {});
    }
  }

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
                    CBackButton(
                      fnk: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddTeacher(),
                          )),
                      ICD: FontAwesomeIcons.plus,
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
                    BlocBuilder<TeacherBloc, TeacherState>(
                      builder: (context, state) {
                        if (state is LoadedTeacherState) {
                          var TeacherList = List<TeacherModel>.from(
                              state.TL.where((e) => e.id != 1));

                          TeacherList.sort(
                            (a, b) {
                              int ta = 0;
                              int tb = 0;
                              if (a.is_Teacher == true) ta = 1;

                              return ta.compareTo(tb);
                            },
                          );

                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: TeacherList.length,
                            itemBuilder: (context, index) {
                              var teacher = TeacherList[index];
                              var profile = Tprofiles?.where(
                                (e) => e.user == teacher.id,
                              );

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      "${teacher.firstName} ${teacher.lastName}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                        "Speciality: ${profile?.first.speciality}"),
                                    leading: SizedBox(
                                      height: 100,
                                      child: CircleAvatar(
                                          backgroundColor: Color(0xFF5f4a95),
                                          backgroundImage: profile
                                                      ?.first.profilePicture !=
                                                  null
                                              ? MemoryImage(profile?.first
                                                  .profilePicture as Uint8List)
                                              : null,
                                          child:
                                              profile?.first.profilePicture !=
                                                      null
                                                  ? null
                                                  : FaIcon(
                                                      FontAwesomeIcons.user,
                                                      size: 50,
                                                    )),
                                    ),
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
                    )
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
