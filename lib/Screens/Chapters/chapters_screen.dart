import 'package:flutter/material.dart';
import 'package:flutter_education/components/my_app_bar.dart';
import 'package:flutter_education/Screens/Chapters/components/body.dart';



class ChaptersScreen extends StatelessWidget {
  final courseId;
  const ChaptersScreen({Key key, @required this.courseId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Body(courseId: courseId),
    );
  }
}
