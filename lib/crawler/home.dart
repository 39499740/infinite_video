/*
 * @Author: 郝怿
 * @Date: 2022-02-09 00:36:36
 * @LastEditTime: 2022-02-12 22:38:55
 * @LastEditors: 郝怿
 * @Description: 
 * @FilePath: /infinite_video/lib/crawler/home.dart
 */

import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:infinite_video/model/bumimi/home_model';

class Home {
  static getHomeData() async {
    var url = Uri.parse('http://www.bumimi77.com/');

    var response = await http.get(url);
    var document = parse(response.body);

    List<BMMHome> homeDataList = [];

    var temp = document.getElementsByClassName("content-wrap g-clear");
    temp.forEach((element) {
      // print(ele
      //     .getElementsByClassName("icontent-left")
      //     .first
      //     .getElementsByClassName('p-mod-label')
      //     .first
      //     .text);

      element.getElementsByClassName("icontent-left").forEach((ele) {
        homeDataList.add(BMMHome.fromElement(ele));
      });
    });
  }
}
