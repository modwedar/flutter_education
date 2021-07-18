import 'package:flutter/material.dart';
import 'package:flutter_education/Screens/Chapter/components/body.dart';
import 'package:flutter_education/components/my_app_bar.dart';

class ChapterScreen extends StatelessWidget {
  final String id;
  const ChapterScreen({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Body(id: id),
    );
  }
}
