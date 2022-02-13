/*
 * @Author: 郝怿
 * @Date: 2022-02-13 22:39:47
 * @LastEditTime: 2022-02-13 23:24:44
 * @LastEditors: 郝怿
 * @Description: 视频详情model
 * @FilePath: /infinite_video/lib/model/bumimi/video_info_model.dart
 */

import "package:html/dom.dart";

class VideoInfoModel {
  String? title;
  String? img;
  String? type;
  String? actor;
  String? area;
  String? date;
  String? detail;
  List<Diversity>? diversity;

  VideoInfoModel(
      {this.title,
      this.img,
      this.type,
      this.actor,
      this.area,
      this.date,
      this.detail,
      this.diversity});

  VideoInfoModel.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    img = json["img"];
    type = json["type"];
    actor = json["actor"];
    area = json["area"];
    date = json["date"];
    detail = json["detail"];
    if (json["diversity"] != null) {
      diversity = <Diversity>[];
      json["diversity"].forEach((v) {
        diversity!.add(new Diversity.fromJson(v));
      });
    }
  }

  VideoInfoModel.fromBmmElement(Document document, String host) {
    title = document
        .getElementsByClassName("title-left g-clear")[0]
        .querySelector("h1")
        ?.text;
    img = document.getElementsByClassName("lzimg")[0].attributes["data-img"];
    document
        .getElementsByClassName("g-clear item-wrap")[0]
        .getElementsByClassName("item")
        .forEach((ele) {
      String? span = ele.querySelector("span")?.text;
      if (span != null) {
        if (span.contains("类型")) {
          type = "";
          ele.getElementsByTagName("a").forEach((e) {
            type = type! + e.text + " ";
          });
          type = type!.trim();
        } else if (span.contains("年代")) {
          date = ele.querySelector("a")?.text;
        } else if (span.contains("地区")) {
          area = ele.querySelector("a")?.text;
        }
      }
    });
    detail = document
        .getElementsByClassName("item-desc js-open-wrap")[0]
        .text
        .replaceAll("简介：", "");
    actor = "";
    diversity = [];
    document
        .getElementsByClassName("details-con2-list")[0]
        .getElementsByTagName("li")
        .forEach((ele) {
      diversity!.add(Diversity.fromBmmElement(ele, host));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["title"] = this.title;
    data["img"] = this.img;
    data["type"] = this.type;
    data["actor"] = this.actor;
    data["area"] = this.area;
    data["date"] = this.date;
    data["detail"] = this.detail;
    if (this.diversity != null) {
      data["diversity"] = this.diversity!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Diversity {
  String? title;
  String? url;

  Diversity({this.title, this.url});

  Diversity.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    url = json["url"];
  }

  Diversity.fromBmmElement(
    Element element,
    String host,
  ) {
    title = element.querySelector("a")?.text;
    url = host + element.querySelector("a")!.attributes["href"].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["title"] = this.title;
    data["url"] = this.url;
    return data;
  }
}
