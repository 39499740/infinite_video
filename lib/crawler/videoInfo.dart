/*
 * @Author: 郝怿
 * @Date: 2022-02-13 22:37:44
 * @LastEditTime: 2022-02-13 23:46:42
 * @LastEditors: 郝怿
 * @Description: 视频详情页解析
 * @FilePath: /infinite_video/lib/crawler/videoInfo.dart
 */

import 'dart:convert';

import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:infinite_video/model/bumimi/video_info_model.dart';

class VideoInfo {
  static getVideoInfo(String url) async {
    var uri = Uri.parse(url);

    var response = await http.get(uri);
    var document = parse(utf8.decode(response.bodyBytes));

    if (url.contains("bumimi")) {
      return VideoInfoModel.fromBmmElement(document, url);
    }
    return null;
  }
}
