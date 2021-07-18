import 'dart:io';

import 'package:flutter_education/models/video.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_education/utilities/api_utilities.dart';
import 'package:flutter_education/models/chapter.dart';
import 'package:flutter_education/models/file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChaptersAPI {
  Future<List<Chapter>> fetchAllChapters(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    List<Chapter> chapters = [];
    Uri categorySubjectsAPI = Uri.parse(base_api + "/api/courses/$id/chapters");
    var response = await http.post(categorySubjectsAPI, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["data"];
      for (var item in data) {
        Chapter chapter =
            Chapter(id: item['id'].toString(), title: item['title'].toString());
        chapters.add(chapter);
      }
    }
    return chapters;
  }

  Future<List<FileModel>> fetchAllChapterFiles(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    List<FileModel> files = [];
    Uri filesAPI = Uri.parse(base_api + "/api/chapters/$id/files");
    var response = await http.get(filesAPI, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["data"];
      for (var item in data) {
        FileModel file = FileModel(
            link: item['link'].toString(),
            title: item['title'].toString(),
            size: item['size'].toString());
        files.add(file);
      }
    }
    return files;
  }

  Future<File> getFileFromUrl(String url) async {
    try {
      var data = await http.get(Uri.parse(url));
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/mypdfonline.pdf");
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  Future<List<Video>> fetchAllChapterVideos(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    List<Video> videos = [];
    Uri filesAPI = Uri.parse(base_api + "/api/chapters/$id/videos");
    var response = await http.get(filesAPI, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["data"];
      for (var item in data) {
        Video video = Video(
            url: item['url'].toString(),
            title: item['title'].toString(),
            size: item['size'].toString());
        videos.add(video);
      }
    }
    return videos;
  }

}
