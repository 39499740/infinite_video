/*
 * @Author: 郝怿
 * @Date: 2022-02-10 23:33:44
 * @LastEditTime: 2022-02-12 22:41:56
 * @LastEditors: 郝怿
 * @Description: 
 * @FilePath: /infinite_video/lib/model/bumimi/home_model
 */


import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' show Element;
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
    
    Element detail = element.getElementsByClassName('y-newfigure-detail')[0];
    
    title = element.getElementsByTagName('title').first.text;
    videos = <Videos>[];
    element.getElementsByTagName('videos').first.children.forEach((v) {
      videos!.add(new Videos.fromElement(v));
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
    img = element.getElementsByTagName('img').first.text;
    title = element.getElementsByTagName('title').first.text;
    subtitle = element.getElementsByTagName('subtitle').first.text;
    url = element.getElementsByTagName('url').first.text;
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
