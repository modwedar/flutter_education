import 'package:flutter/material.dart';
import 'package:flutter_education/Screens/Subjects/components/subject_card.dart';
import 'package:flutter_education/api/subjects_api.dart';
import 'package:flutter_education/components/my_button.dart';
import 'package:flutter_education/models/subject.dart';
import 'package:url_launcher/url_launcher.dart';

class Body extends StatefulWidget {
  const Body();

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  final SubjectsAPI _subjectsAPI = SubjectsAPI();

  @override
  Widget build(BuildContext context) {


    return FutureBuilder(
      future: _subjectsAPI.fetchAllSubjects(),
      builder: (context, AsyncSnapshot snapshot){
        switch(snapshot.connectionState) {
          case ConnectionState.waiting:
            return _loading();
            break;
          case ConnectionState.active:
            return _loading();
            break;
          case ConnectionState.none:
            return Container(child: Text("none"));
            break;
          case ConnectionState.done:
            if(snapshot.error != null){
              return Center(child: Container(child: Text(snapshot.error.toString())));
            } else {
              if(snapshot.hasData){
                List<Subject> subjects = snapshot.data;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      _applyImage(),
                      _applyTextButton(),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, position){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SubjectCard(title: subjects[position].title, id: subjects[position].id),
                          );
                        },
                        itemCount: subjects.length,
                      ),
                    ],
                  ),
                );
              } else {
                return Center(child: Container(child: Text("No data")));
              }
            }
            break;
        }
        return Center(child: Container(child: Text("error in connection")));
      },
    );
  }

  Image _applyImage(){
    return Image(
      image: AssetImage("assets/images/banner.jpg"),
    );
  }

  Widget _applyTextButton(){
    return MyButton(
      onClick: () async {
        const url = "https://forms.gle/EQPH9A2y7YQTMdUL9";
        if (await canLaunch(url))
        await launch(url);
        else
        throw "Could not launch $url";
      },
      text: "التقديم على الجامعات",
    );
  }

  Widget _loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

