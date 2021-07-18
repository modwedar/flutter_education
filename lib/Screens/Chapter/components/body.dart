import 'package:flutter/material.dart';
import 'package:flutter_education/Screens/Chapters/components/chapter_card.dart';
import 'package:flutter_education/Screens/Videos/videos_screen.dart';
import 'package:flutter_education/models/subchapter.dart';
import 'package:flutter_education/Screens/Files/files_screen.dart';


class Body extends StatelessWidget {
  final String id;

  Body({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SubChapter> subs = _getList(context, id);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return ChapterCard(title: subs[index].title, onTap: subs[index].onTap, icon: subs[index].icon);
            }),
      ),
    );
  }
  List<SubChapter> _getList(BuildContext context, String id) {
    List<SubChapter> subs = [];
    subs.add(
        SubChapter(onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FilesScreen(id: id)));
        }, title: "الملفات", icon: Icon(Icons.file_copy)));
    subs.add(
        SubChapter(onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => VideoScreen(id: id)));
        }, title: "الفيديوهات", icon: Icon(Icons.video_collection_rounded)));
    subs.add(
        SubChapter(onTap: () {}, title: "الزووم", icon: Icon(Icons.video_call)));
    return subs;
  }
}
