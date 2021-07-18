import 'package:flutter/material.dart';
import 'package:flutter_education/Screens/Signup/components/background.dart';
import 'package:flutter_education/api/register_student.dart';
import 'package:flutter_education/api/register_teacher.dart';
import 'package:flutter_education/components/rounded_button.dart';
import 'package:flutter_education/components/rounded_input_field.dart';
import 'package:flutter_education/constants.dart';
import 'package:flutter_education/Screens/Subjects/subjects_screen.dart';
import 'package:flutter_education/models/student.dart';
import 'package:flutter_education/models/teacher.dart';
import 'package:flutter_education/models/user_class.dart';
import 'package:flutter_education/database/firebase_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  final String phone;
  final String otp;

  const Body({Key key, @required this.phone, this.otp}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String dropdownValue = 'المرحلة الأساسية والإعدادية';
  TextEditingController _controller = TextEditingController();
  UserClass userClass;
  FirebaseMethods _firebaseMethods = FirebaseMethods();
  Student student;
  RegisterStudent _registerStudent = RegisterStudent();

  RegisterTeacher _registerTeacher = RegisterTeacher();
  bool _progressVisibility = false;

  bool _isStudent = true;

  List<String> grades = [
    'المرحلة الأساسية والإعدادية',
    'الصف الثاني الثانوي (التوجيهي)',
    'الجامعات'
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Background(
        child: Stack(
          children: [
            Visibility(
              visible: !_progressVisibility,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "التسجيل",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: h2,
                        fontFamily: 'ElMessiri'),
                  ),
                  Image(
                    image: AssetImage("assets/images/signup.png"),
                  ),
                  RoundedInputField(
                    hintText: "اسمك",
                    onChanged: (value) {},
                    drawable: Icon(Icons.person),
                    controller: _controller,
                  ),
                  ListTile(
                    title: const Text(
                      'طالب',
                      style: TextStyle(fontFamily: 'ElMessiri'),
                    ),
                    leading: Radio(
                        value: true,
                        groupValue: _isStudent,
                        onChanged: (value) {
                          setState(() {
                            _isStudent = value;
                          });
                        }),
                  ),
                  ListTile(
                    title: const Text(
                      'مدرس',
                      style: TextStyle(fontFamily: 'ElMessiri'),
                    ),
                    leading: Radio(
                        value: false,
                        groupValue: _isStudent,
                        onChanged: (value) {
                          setState(() {
                            _isStudent = value;
                          });
                        }),
                  ),
                  Visibility(
                    visible: _isStudent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton(
                          value: dropdownValue,
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: grades
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontFamily: 'ElMessiri'),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(width: size.width * 0.03),
                        Text(
                          "اختار الصف الدراسي",
                          style: TextStyle(fontFamily: 'ElMessiri'),
                        ),
                      ],
                    ),
                  ),
                  RoundedButton(
                    text: "تسجيل",
                    onClick: () {
                      _register();
                    },
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _progressVisibility,
              child: Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _register() async {
    setState(() {
      _progressVisibility = true;
    });

    if(_isStudent){
      int lvl;
      switch (dropdownValue) {
        case "المرحلة الأساسية والإعدادية":
          lvl = 1;
          break;
        case "الصف الثاني الثانوي (التوجيهي)":
          lvl = 2;
          break;
        case "الجامعات":
          lvl = 3;
          break;
      }
      //userClass = UserClass(name: _controller.text, level: lvl);
      //await _firebaseMethods.sendToUsersDatabase(userClass);
      student = Student(
          name: _controller.text,
          category_id: lvl.toString(),
          number: widget.phone.substring(1),
          otp: widget.otp);
      Student _futureStudent = await _registerStudent.register(student);
      if (_futureStudent != null) {
        String token = await _registerStudent.getToken(student);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
        prefs.setString('level', lvl.toString());
        prefs.setString('id', _futureStudent.id.toString());
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SubjectsScreen()));
      }
    } else {
      Teacher teacher = Teacher(
          name: _controller.text,
          number: widget.phone.substring(1),
          otp: widget.otp
      );
      Teacher _futureTeacher = await _registerTeacher.register(teacher);
      if (_futureTeacher != null) {
        String token = await _registerTeacher.getToken(teacher);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
        prefs.setString('level', 'مدرس');
        prefs.setString('id', _futureTeacher.id.toString());
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SubjectsScreen()));
      }
    }

  }
}
