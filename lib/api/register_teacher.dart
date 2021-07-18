import 'dart:developer';

import 'package:flutter_education/models/teacher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_education/utilities/api_utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterTeacher {
  Future<Teacher> register(Teacher teacher) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('otp', teacher.otp);
    final response = await http.post(
      Uri.parse(base_api + "/api/teachers/register"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': teacher.name,
        'number': teacher.number.toString(),
        'otp': teacher.otp
      }),
    );
    if (response.statusCode == 201) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["data"];
      return Teacher.fromJson(data);
    } else {
      throw Exception('Failed to create teacher.');
    }
  }

  Future<String> getToken(Teacher teacher) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String otp = prefs.getString('otp');
    final response = await http.post(
      Uri.parse(base_api + "/api/teachers/token"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'number': teacher.number,
        'otp': otp
      }),
    );
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      log(jsonData.toString());
      var data = jsonData["data"];
      var token = data["token"];
      return token.toString();
    } else {
      throw Exception('Failed to get token.');
    }
  }
}