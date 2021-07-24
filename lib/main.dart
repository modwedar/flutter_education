import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_education/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_education/constants.dart';
import 'package:flutter_education/models/nav_item.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/ad_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isSkip = prefs.getBool('skip_ad');
  runApp(MyApp(isSkip));
}

class MyApp extends StatelessWidget {
  var isSkip;
  MyApp(this.isSkip);
  @override
  Widget build(BuildContext context) {
    if(isSkip == null){
      isSkip = false;
    }
    return ChangeNotifierProvider(
      create: (context) => NavItems(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Education',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(color: Colors.white, elevation: 0),
        ),
        home: WelcomeScreen(),
      ),
    );
  }
}
