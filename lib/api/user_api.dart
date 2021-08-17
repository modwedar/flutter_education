import 'dart:developer';

import 'package:flutter_education/api/register_student.dart';
import 'package:flutter_education/models/student.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_education/utilities/api_utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserApi {
  Future<bool> checkUserIfRegistered(String number, String otp) async {

    RegisterStudent _registerStudent = RegisterStudent();

    final response = await http.post(
      Uri.parse(base_api + "/api/user/check"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'number': number,
      }),
    );
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["data"];
      if(data != null ){
        Student student = Student.fromJson(data);
        student.otp = otp;
        _registerStudent.changeOtp(student);
        String token = await _registerStudent.getToken(student);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
        prefs.setString('level', student.category_id);
        prefs.setString('id', student.id.toString());
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

}
