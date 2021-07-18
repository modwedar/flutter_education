import 'package:flutter/material.dart';
import 'package:flutter_education/utilities/api_utilities.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_education/models/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentProfile {
  Future<Student> getStudentData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id');
    final response = await http.get(
      Uri.parse(base_api + "/api/students/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["data"];
      Student student = Student(name: data["name"], category_id: data["category_id"].toString(), number: data["number"].toString(), avatar: data["avatar"]);
      return student;
    } else {
      throw Exception('Can\'t get student data.');
    }
  }
}