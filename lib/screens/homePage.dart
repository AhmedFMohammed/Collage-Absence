import 'package:schoolattendance/repository/auth/userAuth.dart';
import 'package:schoolattendance/screens/schedule.dart';
import 'package:schoolattendance/screens/settings/profile.dart';
import 'package:schoolattendance/screens/stages.dart';
import 'package:schoolattendance/screens/user/loginPage.dart';
import 'package:schoolattendance/services/models/user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/customCard.dart';
import 'attendance.dart';
import 'settings/students.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  GlobalKey _key = LabeledGlobalKey("button_icon");
  late OverlayEntry _overlayEntry;
  late Size buttonSize;
  late Offset buttonPosition;
  bool isMenuOpen = false;
  AnimationController? _animationController;
  UserAuth _userAuth = UserAuth();
  UserModel? user;
  @override
  void initState() {
    getuser();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _key = LabeledGlobalKey("button_icon");
    super.initState();
  }

  getuser() async {
    user = await _userAuth.getUserInfo();

    setState(() {});
  }

  void openMenu(BuildContext context1) {
    _overlayEntry = OverlayEntry(
      builder: (context1) {
        return Positioned(
          top: 120,
          right: 15,
          child: Material(
              color: Colors.transparent,
              child: Container(
                  height: UserAuth.role ? 150 : 100,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icbtns[0],
                        onPressed: () {
                          closeMenu();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileScreen()));
                        },
                      ),
                      Visibility(
                        visible: UserAuth.role as bool,
                        child: IconButton(
                          icon: Icbtns[1],
                          onPressed: () {
                            closeMenu();

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StudentsScreen()));
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icbtns[2],
                        onPressed: () async {
                          closeMenu();
                          final SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.remove("token");
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                              (route) => false);
                        },
                      )
                    ],
                  ))),
        );
      },
    );
    _animationController?.forward();
    Overlay.of(context).insert(_overlayEntry);
    isMenuOpen = !isMenuOpen;
  }

  void closeMenu() {
    _overlayEntry.remove();
    _animationController?.reverse();
    isMenuOpen = !isMenuOpen;
  }

  List<FaIcon> Icbtns = [
    FaIcon(FontAwesomeIcons.user),
    FaIcon(FontAwesomeIcons.users),
    FaIcon(FontAwesomeIcons.arrowRightFromBracket),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (isMenuOpen) {
            closeMenu();
          }
        },
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: SafeArea(
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
                          Text(
                            user == null
                                ? "Hello,"
                                : "Hello, ${user?.firstName}",
                            style: TextStyle(
                                color: Color(0xFF5f4a95),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                              key: _key,
                              width: 50,
                              height: 50,
                              child: GestureDetector(
                                onTap: () {
                                  if (isMenuOpen) {
                                    closeMenu();
                                  } else {
                                    openMenu(context);
                                  }
                                },
                                child: CircleAvatar(
                                  backgroundColor: Color(0xFF5f4a95),
                                  child: AnimatedIcon(
                                    icon: AnimatedIcons.menu_close,
                                    progress: _animationController!,
                                    color: Colors.white,
                                  ),
                                ),
                              ))
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
                            Column(
                              children: [
                                Ccard(
                                    ficon: FontAwesomeIcons.usersBetweenLines,
                                    title: "Stages",
                                    color1: Color.fromARGB(255, 136, 131, 174),
                                    color2: Color.fromARGB(255, 120, 112, 193),
                                    fnk: () {
                                      if (isMenuOpen) {
                                        closeMenu();
                                      }
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  StagesScreen()));
                                    }),
                                Ccard(
                                    ficon: FontAwesomeIcons.calendarDay,
                                    title: "Schedule",
                                    color1: Color.fromARGB(255, 117, 97, 147),
                                    color2: Color.fromARGB(255, 99, 66, 132),
                                    fnk: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ScheduleScreen()));
                                      if (isMenuOpen) {
                                        closeMenu();
                                      }
                                    }),
                                Ccard(
                                    ficon: FontAwesomeIcons.listCheck,
                                    title: "Attendance",
                                    color1: Color.fromARGB(255, 103, 86, 146),
                                    color2: Color.fromARGB(255, 81, 55, 146),
                                    fnk: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AttendanceScreen()));
                                      if (isMenuOpen) {
                                        closeMenu();
                                      }
                                    }),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Made By Solution Guide",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
