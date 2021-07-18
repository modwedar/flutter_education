import 'package:flutter/material.dart';

class ChapterCard extends StatelessWidget {
  final String title;
  final Function onTap;
  final Icon icon;
  const ChapterCard({Key key, @required this.title, @required this.onTap, @required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  title,
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              icon,
            ],
          ),
        ),
      ),
    );
  }
}
