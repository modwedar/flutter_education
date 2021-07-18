import 'package:flutter/material.dart';
import 'package:flutter_education/Screens/Files/components/body.dart';
import 'package:flutter_education/components/my_app_bar.dart';

class FilesScreen extends StatelessWidget {
  final String id;
  const FilesScreen({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Body(id: id),
    );
  }
}
