import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_education/models/subject.dart';
import 'package:flutter_education/utilities/api_utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubjectsAPI {
  Future<List<Subject>> fetchAllSubjects() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String level = prefs.getString('level');
    List<Subject> subjects = [];
    Uri categorySubjectsAPI = Uri.parse(base_api + "/api/categories/$level/subjects");
    String token = prefs.getString('token');
    var response = await http.get(
        categorySubjectsAPI,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }
    );

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["data"];
      for (var item in data) {
        Subject subject = Subject(item['id'].toString(),
            item['title'].toString(), item['category_id'].toString());
        subjects.add(subject);
      }
    }
    return subjects;
  }
}
