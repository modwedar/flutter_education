import 'package:flutter/material.dart';
import 'package:flutter_education/Screens/Files/components/file_card.dart';
import 'package:flutter_education/Screens/Videos/components/video_player.dart';
import 'package:flutter_education/api/chapters_api.dart';
import 'package:flutter_education/models/video.dart';
import 'package:shimmer/shimmer.dart';

class Body extends StatelessWidget {
  final String id;

  Body({Key key, this.id}) : super(key: key);

  final ChaptersAPI _chaptersAPI = ChaptersAPI();

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: _chaptersAPI.fetchAllChapterVideos(id),
          builder: (context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return _loading(_size);
                break;
              case ConnectionState.active:
                return _loading(_size);
                break;
              case ConnectionState.none:
                return Container(child: Text("none"));
                break;
              case ConnectionState.done:
                if (snapshot.error != null) {
                  return Center(
                      child: Container(child: Text(snapshot.error.toString())));
                } else {
                  if (snapshot.hasData) {
                    List<Video> videos = snapshot.data;
                    return ListView.builder(
                        itemCount: videos.length,
                        itemBuilder: (context, index) {
                          return FileCard(
                            title: videos[index].title,
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MyVideoPlayer(url: videos[index].url)));
                            },
                            icon: Icon(Icons.ondemand_video_sharp),
                            size: videos[index].size,
                          );
                        });
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

  Widget _loading(Size size) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[700],
      highlightColor: Colors.grey[100],
      direction: ShimmerDirection.ltr,
      period: Duration(seconds: 3),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: size.height * 0.15,
            child: Card(
              child: Container(),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: size.height * 0.15,
            child: Card(
              child: Container(),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: size.height * 0.15,
            child: Card(
              child: Container(),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _showCodeDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("جاري التحميل..."),
          content: SingleChildScrollView(
            child: Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }
}
