import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StageCard extends StatelessWidget {
  int? students, classes;
  Color? color1;
  Color? color2;
  String? Stage;
  IconData? ficd, icangle;
  Function()? fnk;

  StageCard({
    this.classes,
    this.color1,
    this.color2,
    this.ficd,
    this.students,
    this.Stage,
    this.fnk,
    this.icangle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: fnk!,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                  colors: [color1!, color2!],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            width: double.infinity,
            height: 150,
            child: Row(
              children: [
                Expanded(
                  flex: 40,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "$Stage",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FaIcon(
                                  icangle,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.user,
                                    color: Color.fromARGB(255, 48, 48, 48),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "$students",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 236, 236, 236),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  //2
                                  FaIcon(
                                    FontAwesomeIcons.usersViewfinder,
                                    color: Color.fromARGB(255, 48, 48, 48),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "$classes",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 236, 236, 236),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
