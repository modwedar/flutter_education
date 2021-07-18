import 'package:flutter/material.dart';
import 'package:flutter_education/constants.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function onClick;
  final Color color, textColor;

  const MyButton(
      {Key key,
        @required this.text,
        @required this.onClick,
        this.color = kPrimaryColor,
        this.textColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 17, horizontal: 40),
          color: color,
          onPressed: onClick,
          child: Text(
            text,
            style: TextStyle(
                color: textColor,
                fontFamily: 'ElMessiri'
            ),
          ),
        ),
      ),
    );
  }
}
