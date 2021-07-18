import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_education/Screens/Subjects/subjects_screen.dart';
import 'package:flutter_education/Screens/Login/login_screen.dart';
import 'package:flutter_education/Screens/Welcome/components/background.dart';
import 'package:flutter_education/components/rounded_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FirebaseAuth.instance.currentUser == null ? SingleChildScrollView(
          child: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("assets/images/logo.png"),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Image(image: AssetImage("assets/images/welcome.png")),
            SizedBox(
              height: size.height * 0.05,
            ),
            RoundedButton(
              text: "تسجيل الدخول بواسطة رقم الهاتف",
              onClick: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ],
        ),
      ),
    ) : SubjectsScreen();
  }
}
