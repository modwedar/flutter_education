import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserClass {
  String name;
  int level;

  UserClass({
    @required this.name,
    @required this.level,
  });

  UserClass.getMap(DocumentSnapshot ds){
    this.name = ds['name'];
    this.level = ds['level'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{
      'name': this.name,
      'level': this.level
    };
    return map;
  }

}
