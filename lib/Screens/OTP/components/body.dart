import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_education/Screens/Login/components/background.dart';
import 'package:flutter_education/Screens/Login/components/show_in_snackbar.dart';
import 'package:flutter_education/Screens/Signup/signup_screen.dart';
import 'package:flutter_education/Screens/Subjects/subjects_screen.dart';
import 'package:flutter_education/api/register_student.dart';
import 'package:flutter_education/api/user_api.dart';
import 'package:flutter_education/constants.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  final String phone;
  Body(this.phone);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _loadingVisibility = false;
  String _verificationCode;
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Background(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Verify ${widget.phone}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: h2,
                  ),
                ),
                Image(
                  image: AssetImage("assets/images/otp.png"),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: PinPut(
                    fieldsCount: 6,
                    textStyle:
                        const TextStyle(fontSize: 25.0, color: Colors.white),
                    eachFieldWidth: 40.0,
                    eachFieldHeight: 55.0,
                    focusNode: _pinPutFocusNode,
                    controller: _pinPutController,
                    submittedFieldDecoration: pinPutDecoration,
                    selectedFieldDecoration: pinPutDecoration,
                    followingFieldDecoration: pinPutDecoration,
                    pinAnimationType: PinAnimationType.fade,
                    onSubmit: (pin) async {
                      try {
                        await FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                                verificationId: _verificationCode,
                                smsCode: pin))
                            .then((value) async {
                          if (value.user != null) {
                            setState(() {
                              _loadingVisibility = true;
                            });
                            checkRegister(pin);
                          }
                        });
                      } catch (e) {
                        FocusScope.of(context).unfocus();
                        showInSnackBar(context, 'invalid OTP');
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        Visibility(
          visible: _loadingVisibility,
          child: _loading(),
        ),
      ],
    );
  }

  void checkRegister(String pin) async {
    UserApi userApi = UserApi();
    bool registered = await userApi.checkUserIfRegistered(widget.phone, pin);
    if (registered) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SubjectsScreen()),
          (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SignUpScreen(phone: widget.phone, otp: pin)),
          (route) => false);
    }
  }

  Widget _loading() {
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          String pin = credential.smsCode;
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              setState(() {
                _loadingVisibility = true;
              });
              checkRegister(pin);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e);
        },
        codeSent: (String verificationID, int resendToken) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }
}
