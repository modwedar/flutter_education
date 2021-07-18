import 'package:flutter/cupertino.dart';

class Student {
  int id;
  String name;
  String category_id;
  String number;
  String otp;
  String avatar;

  Student(
      {this.id,
      @required this.name,
      @required this.category_id,
      @required this.number,
      this.otp,
      this.avatar});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'] as String,
      id: json['id'] as int,
      category_id: json['category_id'].toString(),
      number: json['number'].toString(),
      avatar: json['avatar'] as String
    );
  }
}
