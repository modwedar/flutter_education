import 'package:flutter/material.dart';
import 'package:flutter_education/Screens/Signup/components/body.dart';

class SignUpScreen extends StatelessWidget {
  final String phone;
  final String otp;

  const SignUpScreen({Key key, @required this.phone, @required this.otp}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(phone: phone, otp: otp),
    );
  }
}