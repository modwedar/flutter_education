import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_education/models/course.dart';
import 'package:flutter_education/utilities/api_utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoursesAPI {
  Future<List<Course>> fetchAllCourses(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    List<Course> courses = [];
    Uri coursesAPI = Uri.parse(base_api + "/api/subjects/$id/courses");
    var response = await http.get(coursesAPI, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["data"];
      for (var item in data) {
        var teacher_id = item['teacher_id'];
        var response = await http.get(Uri.parse(base_api + "/api/teachers/$teacher_id"), headers: {
          'Accept': 'application/json',
        });
        var jsonData = jsonDecode(response.body);
        var data = jsonData["data"];
        String teacher = data["name"].toString();
        Course course = Course(
            id: item['id'].toString(),
            title: item['title'].toString(),
            subject_id: item['subject_id'],
            teacher: teacher,
            img_url: item['img_url'].toString());
        courses.add(course);
      }
    }
    return courses;
  }
  Future<bool> checkCourse(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    Uri courseAPI = Uri.parse(base_api + "/api/courses/$id/chapters");
    var response = await http.post(courseAPI, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var jsonData = jsonDecode(response.body);
    if(jsonData.containsKey("data")){
      return true;
    }
    return false;
  }

  Future<bool> checkCode(String id, String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    Uri courseAPI = Uri.parse(base_api + "/api/courses/$id/chapters");
    var response = await http.post(courseAPI, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
      body: jsonEncode(<String, String>{
        'code': code,
      })
    );
    var jsonData = jsonDecode(response.body);
    if(jsonData.containsKey("data")){
      return true;
    }
    print("code issssss $code");
    print("issssss ${response.body}");
    return false;
  }

}
