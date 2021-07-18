import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_education/Screens/Login/components/background.dart';
import 'package:flutter_education/Screens/OTP/otp_screen.dart';
import 'package:flutter_education/components/rounded_button.dart';
import 'package:flutter_education/components/rounded_input_field.dart';
import 'package:flutter_education/constants.dart';

class Body extends StatelessWidget {
  String codeOfCountry;
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "تسجيل الدخول",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: 'ElMessiri',
                  fontSize: h2,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Image(
              height: size.height * 0.35,
              image: AssetImage("assets/images/login.png"),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              onChanged: (value) {},
              hintText: "رقمك",
              phone: true,
              drawable: CountryCodePicker(
                initialSelection: 'JO',
                favorite: ['+962', 'JO'],
                onInit: (countryCode) {
                  codeOfCountry = countryCode.toString();
                },
                onChanged: (countryCode) {
                  codeOfCountry = countryCode.toString();
                },
              ),
              controller: _controller,
            ),
            RoundedButton(
              text: "التالي",
              onClick: () {
                if(_controller.text.length > 6){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OTPScreen(codeOfCountry + _controller.text)));
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}
