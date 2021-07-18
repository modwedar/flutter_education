import 'package:flutter/material.dart';

class Course {

  String id, title, img_url, teacher;
  int subject_id;

  Course({@required this.id, @required this.title, this.img_url, this.subject_id, this.teacher});
}