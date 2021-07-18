import 'package:flutter/material.dart';

class CourseBundle {
  final int id;
  final String title, imageSrc, teacher;
  final Color color;

  CourseBundle(
      {this.id,
      this.title,
      this.imageSrc,
      this.teacher,
      this.color});
}