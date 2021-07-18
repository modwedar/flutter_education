import 'package:youtube_explode_dart/youtube_explode_dart.dart' as ytt;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';


class YoutubeApi {
  var yt = ytt.YoutubeExplode();


  Future<StreamManifest> getStreams(String url) async{
    String id = getIdFromUrl(url);
    var yt = ytt.YoutubeExplode();
    var manifest = await yt.videos.streamsClient.getManifest(id);
    return manifest;
  }

  String getIdFromUrl(String url){
    RegExp regExp = new RegExp(
      r'.*(?:(?:youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/)|(?:(?:watch)?\?v(?:i)?=|\&v(?:i)?=))([^#\&\?]*).*',
      caseSensitive: false,
      multiLine: false,
    );
    final id = regExp.firstMatch(url).group(1);
    return id;
  }
}
