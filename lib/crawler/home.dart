/*
 * @Author: 郝怿
 * @Date: 2022-02-09 00:36:36
 * @LastEditTime: 2022-02-13 23:12:08
 * @LastEditors: 郝怿
 * @Description: 
 * @FilePath: /infinite_video/lib/crawler/home.dart
 */

import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:infinite_video/model/bumimi/home_model.dart';

class Home {
  static getHomeData() async {
    var url = Uri.parse('http://www.bumimi77.com/');

    var response = await http.get(url);
    var document = parse(response.body);

    List<HomeModel> homeDataList = [];

    document.getElementsByClassName("content-wrap g-clear").forEach((element) {
      element.getElementsByClassName("icontent-left").forEach((ele) {
        homeDataList.add(HomeModel.fromElement(ele));
      });
    });

    return homeDataList;
  }
}
