import 'package:flutter/material.dart';
import 'package:flutter_education/Screens/Profile/components/profile_list_item.dart';
import 'package:flutter_education/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_education/database/firebase_methods.dart';
import 'package:flutter_education/models/student.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter_education/constants.dart';
import 'package:flutter_education/api/student_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FirebaseMethods _firebaseMethods = FirebaseMethods();
  StudentProfile _studentProfile = StudentProfile();

  @override
  Widget build(BuildContext context) {
    var profileInfo = Expanded(
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            margin: EdgeInsets.only(top: 30),
            child: Stack(children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/images/person.png"),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      color: Color(0xFFFFC107), shape: BoxShape.circle),
                  child: Icon(
                    LineAwesomeIcons.pen,
                    color: Color(0xFF212121),
                    size: 15,
                  ),
                ),
              )
            ]),
          ),
          SizedBox(height: 20),
          FutureBuilder(
            future: _studentProfile.getStudentData(),
            builder: (context, AsyncSnapshot snapshot) {
              switch(snapshot.connectionState) {
                case ConnectionState.waiting:
                  return _loading();
                  break;
                case ConnectionState.active:
                  return _loading();
                  break;
                case ConnectionState.none:
                  return Container(child: Text("Connection None"));
                  break;
                case ConnectionState.done:
                  if(snapshot.error != null){
                    return Center(child: Container(child: Text(snapshot.error.toString())));
                  } else {
                    if(snapshot.hasData){
                      Student student = snapshot.data;
                      String categoryId = student.category_id;
                      String level;
                      switch(categoryId){
                        case "1":
                          level = "المرحلة الأساسية والإعدادية";
                          break;
                        case "2":
                          level = "المرحلة الأساسية والإعدادية";
                          break;
                        case "2":
                          level = "الجامعات";
                          break;
                      }
                      return Column(
                        children: [
                          Text(student.name, style: kTitleTextStyle),
                          SizedBox(height: 5),
                          Text(level,
                              style: kCaptionTextStyle),
                        ],
                      );
                    } else {
                      return Center(child: Container(child: Text("No data")));
                    }
                  }
                  break;
              }
              return Center(child: Container(child: Text("error in connection")));
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 30),
        profileInfo,
        SizedBox(width: 30),
      ],
    );
    return Column(
      children: [
        SizedBox(height: 30),
        header,
        Expanded(
          child: ListView(
            children: [
              ProfileListItem(
                icon: LineAwesomeIcons.video_1,
                text: 'كورساتي',
              ),
              ProfileListItem(
                icon: LineAwesomeIcons.facebook_messenger,
                text: 'الشات',
              ),
              ProfileListItem(
                icon: LineAwesomeIcons.pen,
                text: 'تعديل الحساب',
              ),
              ProfileListItem(
                icon: LineAwesomeIcons.cog,
                text: 'الإعدادات',
              ),
              ProfileListItem(
                icon: LineAwesomeIcons.alternate_sign_out,
                text: 'تسجيل الخروج',
                hasNavigation: false,
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.remove('token');
                  prefs.remove('level');
                  prefs.remove('id');
                  _firebaseMethods.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                      (route) => false);
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _loading() {
    return Column(
      children: [
        Text('name', style: kTitleTextStyle),
        SizedBox(height: 5),
        Text('level',
            style: kCaptionTextStyle),
      ],
    );
  }
}
