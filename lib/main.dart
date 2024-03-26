import 'package:schoolattendance/bloc/attendancebloc/attendance_bloc.dart';
import 'package:schoolattendance/bloc/lessonbloc/lesson_bloc.dart';
import 'package:schoolattendance/bloc/studentbloc/student_bloc.dart';
import 'package:schoolattendance/bloc/teacherbloc/teacher_bloc.dart';
import 'package:schoolattendance/repository/auth/userAuth.dart';
import 'package:schoolattendance/screens/homePage.dart';
import 'package:schoolattendance/screens/user/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? token;
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  token = sharedPreferences.getString("token");
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => StudentBloc()..add(AllStudentEvent())),
    BlocProvider(create: (context) => LessonBloc()..add(AllLessonEvent())),
    BlocProvider(create: (context) => TeacherBloc()..add(AllTeacherEvent())),
    BlocProvider(
        create: (context) => AttendanceBloc()..add(AllAttendanceEvent())),
  ], child: MyApp(token)));
}

class MyApp extends StatelessWidget {
  String? token;
  MyApp(this.token);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (token != null) {
      UserAuth.Token = token as String;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: token == null ? LoginPage() : MyHomePage(),
    );
  }
}
