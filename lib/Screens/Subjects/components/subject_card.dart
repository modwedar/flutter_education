import 'package:flutter/material.dart';
import 'package:flutter_education/Screens/Courses/courses_screen.dart';

class SubjectCard extends StatelessWidget {

  String id;
  String title;

  SubjectCard({this.id, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 0, 8, 16),
      child: GestureDetector(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CoursesScreen(subjectId: id)));
        },
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              const Radius.circular(5.0)
            ),
            gradient: LinearGradient(colors: [Color.fromRGBO(108, 115, 255, 1), Color.fromRGBO(58, 63, 255, 1)],
              begin: Alignment.topCenter,
              end: Alignment.topRight
            )
          ),
          child: Text(title, style: TextStyle(color: Colors.white, fontSize: 22), textAlign: TextAlign.right),
        ),
      ),
    );
  }
}
