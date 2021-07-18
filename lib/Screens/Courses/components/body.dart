import 'package:flutter/material.dart';
import 'package:flutter_education/Screens/Courses/components/course_bundle_card.dart';
import 'package:flutter_education/Screens/Courses/models/course_model.dart';
import 'package:flutter_education/Screens/Chapters/chapters_screen.dart';
import 'package:flutter_education/api/courses_api.dart';
import 'package:flutter_education/models/course.dart';



class Body extends StatelessWidget {

  final String subjectId;
  Orientation orientation;
  final CoursesAPI _coursesAPI = CoursesAPI();
  final GlobalKey<ScaffoldState> scaffoldKey;

  Body({Key key, this.subjectId, this.scaffoldKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    orientation = MediaQuery.of(context).orientation;
    return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
        children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: FutureBuilder(
                  future: _coursesAPI.fetchAllCourses(subjectId),
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
                            List<Course> courses = snapshot.data;
                            return GridView.builder(
                              itemCount: courses.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: orientation == Orientation.landscape ? 2 : 1,
                                crossAxisSpacing: orientation == Orientation.landscape ? 20 : 0,
                                mainAxisSpacing: 20,
                                childAspectRatio: 1.65,
                              ),
                              itemBuilder: (context, index) {
                                return CourseBundleCard(
                                  courseBundle: CourseBundle(
                                    id: int.parse(courses[index].id),
                                    title: courses[index].title,
                                    imageSrc: courses[index].img_url,
                                    teacher: courses[index].teacher,
                                    color: Color(0xFFD82D40),
                                  ),
                                  onClick: () async {
                                    bool check = await _coursesAPI.checkCourse(courses[index].id);
                                    if(check){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ChaptersScreen(courseId: courses[index].id)));
                                    } else {
                                      _showCodeDialog(context, courses[index].id);
                                    }
                                  },
                                );
                              }
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
              ),
            ),
        ],
      ),
          ),
    );
  }
  Future<void> _showCodeDialog(BuildContext context, String id) async {
    TextEditingController _controller = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ادخل الكود'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                    keyboardType: TextInputType.number,
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "مثال: 16478854745301",
                    )
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ادخال'),
              onPressed: () async {
                bool check = await _coursesAPI.checkCode(id, _controller.text);
                if(check){
                  _openCourse(context);
                  Navigator.pop(context);
                } else {
                  scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        content: Text('الكود غير صحيح'),
                      )
                  );
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  _openCourse(BuildContext context){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ChaptersScreen()));
    });
  }

  Widget _loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
