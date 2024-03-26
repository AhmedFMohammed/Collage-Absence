import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CBackButton extends StatelessWidget {
  Function()? fnk;
  Color? color;
  IconData? ICD;
  CBackButton(
      {this.ICD = FontAwesomeIcons.angleLeft,
      this.fnk,
      this.color = const Color(0xFF5f4a95)});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: GestureDetector(
        onTap: fnk,
        child: CircleAvatar(
            backgroundColor: color,
            child: Center(
                child: FaIcon(
              ICD,
              color: Colors.white,
            ))),
      ),
    );
  }
}
