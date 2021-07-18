import 'package:flutter/material.dart';
import 'package:flutter_education/Screens/Chapter/chapter_screen.dart';
import 'package:flutter_education/api/chapters_api.dart';
import 'package:flutter_education/models/chapter.dart';
import 'chapter_card.dart';

class Body extends StatelessWidget {
  final courseId;
  Body({Key key, @required this.courseId}) : super(key: key);

  final ChaptersAPI _chaptersAPI = ChaptersAPI();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: _chaptersAPI.fetchAllChapters(courseId),
          builder: (context, AsyncSnapshot snapshot){
            switch(snapshot.connectionState) {
              case ConnectionState.waiting:
                return _loading();
                break;
              case ConnectionState.active:
                return _loading();
                break;
              case ConnectionState.none:
                return Container(child: Text("none"));
                break;
              case ConnectionState.done:
                if(snapshot.error != null){
                  return Center(child: Container(child: Text(snapshot.error.toString())));
                } else {
                  if(snapshot.hasData){
                    List<Chapter> chapters = snapshot.data;
                    return ListView.builder(
                        itemCount: chapters.length,
                        itemBuilder: (context, index) {
                          return ChapterCard(
                            title: chapters[index].title,
                            icon: Icon(Icons.folder),
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => ChapterScreen(id: chapters[index].id)));
                            },
                          );
                        }
                    );
                  } else {
                    return Center(child: Container(child: Text("No data")));
                  }
                }
                break;
            }
            return Center(child: Container(child: Text("error in connection")));
          },
        ),
      ),
    );
  }
  Widget _loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
