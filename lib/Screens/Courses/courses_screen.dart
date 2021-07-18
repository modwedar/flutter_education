import 'package:flutter/material.dart';
import 'package:flutter_education/components/my_bottom_nav_bar.dart';
import 'package:flutter_education/size_config.dart';
import 'package:flutter_education/components/my_app_bar.dart';
import 'package:flutter_education/Screens/Courses/components/body.dart';

class CoursesScreen extends StatelessWidget {
  final String subjectId;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  CoursesScreen({Key key, this.subjectId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: MyAppBar(),
      body: Body(subjectId: subjectId, scaffoldKey: scaffoldKey),
      drawer: Drawer(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}