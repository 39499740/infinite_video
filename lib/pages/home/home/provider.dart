/*
 * @Author: 郝怿
 * @Date: 2022-02-12 23:05:32
 * @LastEditTime: 2022-02-12 23:54:06
 * @LastEditors: 郝怿
 * @Description: 首页数据
 * @FilePath: /infinite_video/lib/pages/home/home/provider.dart
 */

import 'package:flutter/material.dart';
import 'package:infinite_video/crawler/home.dart';
import 'package:infinite_video/model/bumimi/home_model.dart';

class HomeProvider extends ChangeNotifier {
  BuildContext context;
  HomeProvider(this.context);

  bool _initialized = false;

  List<BMMHome> _homeAreaDataList = [];
  List<BMMHome> get homeAreaDataList => _homeAreaDataList;

  void init() {
    if (!_initialized) {
      _initialized = true;
      Future.delayed(const Duration(milliseconds: 100), () async {
        _homeAreaDataList = await Home.getHomeData();
        notifyListeners();
      });
    }
  }
}
