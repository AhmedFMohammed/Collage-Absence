import 'package:schoolattendance/screens/Stages/stagedetailes.dart';
import 'package:flutter/material.dart';

import '../widgets/cbackbutton.dart';
import '../widgets/ccardWithLine.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //header
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
                  "Attendance",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
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
                    ListLessonsView(
                      is_Attendance: true,
                    )
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
