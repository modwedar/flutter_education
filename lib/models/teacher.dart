import 'package:flutter/cupertino.dart';

class Teacher {
  int id;
  String name, number, otp;

  Teacher({this.id,@required this.name,@required this.number, this.otp});

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
        name: json['name'] as String,
        id: json['id'] as int,
        number: json['number'] as String,
    );
  }
}