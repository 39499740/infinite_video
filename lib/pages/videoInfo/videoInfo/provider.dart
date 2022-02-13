/*
 * @Author: 郝怿
 * @Date: 2022-02-13 22:28:29
 * @LastEditTime: 2022-02-13 23:52:41
 * @LastEditors: 郝怿
 * @Description: 
 * @FilePath: /infinite_video/lib/pages/videoInfo/videoInfo/provider.dart
 */

import 'package:flutter/material.dart';
import 'package:infinite_video/crawler/videoInfo.dart';

import 'package:infinite_video/model/bumimi/home_model.dart';
import 'package:infinite_video/model/bumimi/video_info_model.dart';

class VideoInfoProvider extends ChangeNotifier {
  BuildContext context;
  Videos videos;
  VideoInfoProvider(this.context, this.videos);

  VideoInfoModel? _videoInfo;
  VideoInfoModel? get videoInfo => _videoInfo;

  bool _initialized = false;

  void init() {
    if (!_initialized) {
      _initialized = true;
      Future.delayed(const Duration(milliseconds: 100), () async {
        _videoInfo = await VideoInfo.getVideoInfo(videos.url!);
        notifyListeners();
      });
    }
  }

  void backBtnClicked() {
    Navigator.pop(context);
  }
}
