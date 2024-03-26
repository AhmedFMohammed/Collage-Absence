import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Ccard extends StatelessWidget {
  Color? color1;
  Color? color2;
  String? title;
  IconData? ficon;
  Function()? fnk;
  Ccard({this.title, this.color1, this.color2, this.ficon, this.fnk});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fnk,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                  colors: [
                    color1!,
                    color2!,
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            width: double.infinity,
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$title",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  Opacity(
                    opacity: 0.2,
                    child: FaIcon(
                      ficon,
                      size: 105,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
