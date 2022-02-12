/*
 * @Author: 郝怿
 * @Date: 2022-02-10 23:33:44
 * @LastEditTime: 2022-02-13 00:04:28
 * @LastEditors: 郝怿
 * @Description: 
 * @FilePath: /infinite_video/lib/model/bumimi/home_model.dart
 */

import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

class BMMHome {
  String? title;
  List<Videos>? videos;

  BMMHome({this.title, this.videos});

  BMMHome.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(new Videos.fromJson(v));
      });
    }
  }

  BMMHome.fromElement(Element element) {
    title = element.getElementsByClassName('p-mod-label').first.text;
    videos = <Videos>[];
    element.getElementsByClassName('y-newfigure').forEach((ele) {
      videos!.add(Videos.fromElement(ele));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.videos != null) {
      data['videos'] = this.videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Videos {
  String? img;
  String? title;
  String? subtitle;
  String? url;

  Videos({this.img, this.title, this.subtitle, this.url});

  Videos.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    title = json['title'];
    subtitle = json['subtitle'];
    url = json['url'];
  }
  Videos.fromElement(Element element) {
    img = element
        .getElementsByTagName('img')
        .first
        .attributes['data-img']
        .toString();
    title = element
        .getElementsByClassName("y-newfigure-detail")
        .first
        .getElementsByClassName("s1")
        .first
        .text;
    subtitle = element
        .getElementsByClassName("y-newfigure-detail")
        .first
        .getElementsByClassName("y-newfigure-desc")
        .first
        .text;
    url = element.querySelector('a')!.attributes['href'].toString();
    if (url!.startsWith("/")) {
      url = "https://www.bumimi77.com" + url!;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.img;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['url'] = this.url;
    return data;
  }
}
