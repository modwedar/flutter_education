import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_education/Screens/Login/components/background.dart';
import 'package:flutter_education/Screens/Signup/signup_screen.dart';
import 'package:flutter_education/Screens/Subjects/subjects_screen.dart';
import 'package:flutter_education/api/user_api.dart';
import 'package:flutter_education/constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Body extends StatefulWidget {
  final String phone;

  Body(this.phone);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _loadingVisibility = false;
  String _verificationCode;
  String currentText = "";
  bool hasError = false;
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType> errorController;
  final formKey = GlobalKey<FormState>();
  bool _codeError = false;
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
                  child: Form(
                    key: formKey,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 30),
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 6,
                          obscureText: true,
                          obscuringCharacter: '*',
                          obscuringWidget: FlutterLogo(
                            size: 24,
                          ),
                          blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          validator: (v) {
                            if (v.length < 3) {
                              return "تصحيح الكود";
                            } else {
                              return null;
                            }
                          },
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor: Colors.white,
                          ),
                          cursorColor: Colors.black,
                          animationDuration: Duration(milliseconds: 300),
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: textEditingController,
                          keyboardType: TextInputType.number,
                          boxShadows: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: Colors.black12,
                              blurRadius: 10,
                            )
                          ],
                          onCompleted: (v) {
                            print("Completed");
                          },
                          // onTap: () {
                          //   print("Pressed");
                          // },
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              currentText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    hasError ? "من فضلك قم بكتابة الكود كاملاً" : "",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'ElMessiri',
                    ),
                  ),
                ),
                Visibility(
                  visible: _codeError,
                  child: Text(
                    'خطأ في الكود',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'ElMessiri',
                    ),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 30),
                  child: ButtonTheme(
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _loadingVisibility = true;
                        });
                        formKey.currentState.validate();
                        // conditions for validating
                        if (currentText.length != 6) {
                          errorController.add(ErrorAnimationType
                              .shake); // Triggering error shake animation
                          setState(() => hasError = true);
                        } else {
                          setState(
                            () {
                              hasError = false;
                            },
                          );
                          try {
                            String pin = textEditingController.text.trim();
                            FirebaseAuth.instance
                                .signInWithCredential(
                                    PhoneAuthProvider.credential(
                                        verificationId: _verificationCode,
                                        smsCode: pin)).catchError((error){
                              setState(() {
                                _loadingVisibility= false;
                                _codeError = true;
                              });
                            }).then((userData) async {
                              if (userData != null) {
                                checkRegister(pin);
                              }
                            });
                          } catch (e) {
                            print(e.toString());
                          }
                        }
                      },
                      child: Center(
                          child: Text(
                        "VERIFY".toUpperCase(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.green.shade300,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.green.shade200,
                            offset: Offset(1, -2),
                            blurRadius: 5),
                        BoxShadow(
                            color: Colors.green.shade200,
                            offset: Offset(-1, 2),
                            blurRadius: 5)
                      ]),
                ),
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
    try {
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
    } catch (e) {
      print(e);
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
          try {
            String pin = credential.smsCode;
            await FirebaseAuth.instance
                .signInWithCredential(credential)
                .then((value) async {
              if (value.user != null) {
                checkRegister(pin);
              }
            });
          } catch (e) {
            print(e);
          }
        },
        verificationFailed: (FirebaseAuthException e) {},
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
    errorController = StreamController<ErrorAnimationType>();
    _verifyPhone();
  }
}
