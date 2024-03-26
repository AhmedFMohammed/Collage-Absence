import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

import '../repository/API/LocalServerAPI/APIdate/APIstage.dart';
import '../services/models/stage.dart';
import '../widgets/cbackbutton.dart';
import '../widgets/ccardWithLine.dart';
import 'Stages/stagedetailes.dart';

class ScheduleScreen extends StatefulWidget {
  ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  CalendarFormat format = CalendarFormat.week;
  DateTime SelectedDay = DateTime.now();
  DateTime FocusedDay = DateTime.now();
  DateTime? GTIME;

  @override
  void initState() {
    super.initState();
  }

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
                  "Schedule",
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
                    TableCalendar(
                      focusedDay: FocusedDay,
                      firstDay: DateTime(DateTime.now().year - 10),
                      lastDay: DateTime(DateTime.now().year + 20),
                      calendarFormat: format,
                      onFormatChanged: (CalendarFormat _format) {
                        setState(() {
                          format = _format;
                        });
                      },
                      onDaySelected: (DateTime selectDay, DateTime focusDay) {
                        setState(() {
                          SelectedDay = selectDay;
                          FocusedDay = focusDay;
                          GTIME = SelectedDay;
                        });
                      },
                      selectedDayPredicate: (date) {
                        return isSameDay(SelectedDay, date);
                      },

                      // Header Style
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        formatButtonTextStyle:
                            TextStyle(color: Color(0xFF5f4a95)),
                        leftChevronIcon: FaIcon(
                          FontAwesomeIcons.angleLeft,
                          color: Color(0xFF5f4a95),
                          size: 18,
                        ),
                        rightChevronIcon: FaIcon(
                          FontAwesomeIcons.angleRight,
                          color: Color(0xFF5f4a95),
                          size: 18,
                        ),
                        formatButtonShowsNext: false,
                      ),

                      // Calender Style
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                            color: Color.fromARGB(144, 95, 74, 149),
                            shape: BoxShape.circle),
                        selectedDecoration: BoxDecoration(
                            color: Color(0xFF5f4a95), shape: BoxShape.circle),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    //list
                    ListLessonsView(
                      is_Schedule: true,
                      day: returnDayName(SelectedDay.weekday),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  returnDayName(int dayID) {
    switch (dayID) {
      case 7:
        return "Sun";

        break;
      case 1:
        return "Mon";

        break;
      case 2:
        return "Tue";

        break;
      case 3:
        return "Wed";

        break;
      case 4:
        return "Thu";

        break;
      case 5:
        return "Fri";

        break;
      case 6:
        return "Sat";

        break;
      default:
    }
  }
}
