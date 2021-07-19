import 'package:flutter/material.dart';
import 'package:flutter_education/api/youtube_api.dart';
import 'package:flutter_education/components/my_app_bar.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:collection/collection.dart';

class MyVideoPlayer extends StatefulWidget {
  final String url;

  const MyVideoPlayer({Key key, this.url}) : super(key: key);

  @override
  _MyVideoPlayerState createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  VideoPlayerController _betterPlayerController;
  TargetPlatform _platform;
  YoutubeApi _youtubeApi = YoutubeApi();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _betterPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: FutureBuilder(
        future: _youtubeApi.getStreams(widget.url),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return _loading();
              break;
            case ConnectionState.active:
              return _loading();
              break;
            case ConnectionState.none:
              return Container(child: Text("Connection None"));
              break;
            case ConnectionState.done:
              if (snapshot.error != null) {
                return Center(
                    child: Container(child: Text(snapshot.error.toString())));
              } else {
                if (snapshot.hasData) {
                  initialVideo(snapshot);
                  return AspectRatio(
                    aspectRatio: 16 / 9,
                    child: VideoPlayer(_betterPlayerController),
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
    );
  }

  Widget _loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void initialVideo(AsyncSnapshot snapshot) {
    StreamManifest streamManifest = snapshot.data;
    final low144 = streamManifest.video.firstWhereOrNull(
        (element) => element.videoQuality == VideoQuality.low144);

    final low240 = streamManifest.video.firstWhereOrNull(
        (element) => element.videoQuality == VideoQuality.low240);

    final medium360 = streamManifest.video.firstWhereOrNull(
        (element) => element.videoQuality == VideoQuality.medium360);

    final medium480 = streamManifest.video.firstWhereOrNull(
        (element) => element.videoQuality == VideoQuality.medium480);

    final high720 = streamManifest.video.firstWhereOrNull(
        (element) => element.videoQuality == VideoQuality.high720);

    String mainResolution;

    if (high720 != null) {
      mainResolution = high720.url.toString();
    } else if (medium480 != null) {
      mainResolution = medium480.url.toString();
    } else if (medium360 != null) {
      mainResolution = medium360.url.toString();
    } else if (low240 != null) {
      mainResolution = low240.url.toString();
    } else {
      mainResolution = low144.url.toString();
    }

    Map<String, String> resolutions = {
      if (low144 != null) '144p': low144.url.toString(),
      if (low240 != null) '240p': low240.url.toString(),
      if (medium360 != null) '360p': medium360.url.toString(),
      if (medium480 != null) '480p': medium480.url.toString(),
      if (high720 != null) '720p': high720.url.toString(),
    };

    _betterPlayerController = VideoPlayerController.network(
        'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }
}
