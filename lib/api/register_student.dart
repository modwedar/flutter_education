import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_education/models/student.dart';
import 'package:flutter_education/utilities/api_utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterStudent {
  Future<Student> register(Student student) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('otp', student.otp);
    final response = await http.post(
      Uri.parse(base_api + "/api/students/register"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': student.name,
        'category_id': student.category_id,
        'number': student.number.toString(),
        'otp': student.otp
      }),
    );
    if (response.statusCode == 201) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["data"];
      return Student.fromJson(data);
    } else {
      throw Exception('Failed to create student.');
    }
  }

  Future<String> getToken(Student student) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String otp = prefs.getString('otp');
    final response = await http.post(
      Uri.parse(base_api + "/api/students/token"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'number': student.number,
        'otp': otp
      }),
    );
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["data"];
      var token = data["token"];
      return token.toString();
    } else {
      throw Exception('Failed to get token.');
    }
  }

  Future changeOtp(Student student) async {
    await http.post(
      Uri.parse(base_api + "/api/student/x5lnm2a1/${student.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'otp': student.otp
      }),
    );
  }
}