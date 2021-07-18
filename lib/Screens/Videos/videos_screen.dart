import 'package:flutter/material.dart';
import 'package:flutter_education/components/my_app_bar.dart';
import 'package:flutter_education/Screens/Videos/components/body.dart';


class VideoScreen extends StatelessWidget {
  final String id;
  const VideoScreen({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Body(id: id),
    );
  }
}
