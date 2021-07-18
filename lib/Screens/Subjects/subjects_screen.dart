import 'package:flutter/material.dart';
import 'package:flutter_education/components/my_bottom_nav_bar.dart';
import 'package:flutter_education/components/my_app_bar.dart';
import 'package:flutter_education/size_config.dart';
import 'package:flutter_education/Screens/Subjects/components/body.dart';

class SubjectsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: MyAppBar(),
      body: Body(),
      drawer: Drawer(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }


}