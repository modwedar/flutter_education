import 'package:flutter/material.dart';
import 'package:flutter_education/Screens/OTP/components/body.dart';

class OTPScreen extends StatelessWidget {
  final String phone;
  OTPScreen(this.phone);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(phone),
    );
  }
}
