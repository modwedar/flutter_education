import 'package:flutter/material.dart';
import 'package:flutter_education/Screens/Profile/components/body.dart';
import 'package:flutter_education/components/my_bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavBar(),
      body: Body(),
    );
  }
}
