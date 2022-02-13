/*
 * @Author: 郝怿
 * @Date: 2022-02-13 22:28:29
 * @LastEditTime: 2022-02-14 00:30:32
 * @LastEditors: 郝怿
 * @Description: 视频详情页面，根据视频Host使用不同逻辑
 * @FilePath: /infinite_video/lib/pages/videoInfo/videoInfo/view.dart
 */

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:infinite_video/common/screen_tools.dart';
import 'package:infinite_video/model/bumimi/home_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class VideoInfoPage extends StatelessWidget {
  late Videos videos;
  VideoInfoPage({required this.videos});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => VideoInfoProvider(context, videos),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final p = context.read<VideoInfoProvider>();
    final pp = Provider.of<VideoInfoProvider>(context, listen: true);
    p.init();
    return Scaffold(
        backgroundColor: Colors.white,
        body: pp.videoInfo == null
            ? Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.grey, size: ScreenTools.getSize(35)),
              )
            : Container(
                child: Stack(children: [
                Positioned(
                  top: ScreenTools.fromSafeTop(30),
                  left: 0,
                  right: 0,
                  child: Container(
                    height: ScreenTools.getSize(164),
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenTools.getSize(18)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ExtendedImage.network(
                          p.videoInfo!.img!,
                          width: ScreenTools.getSize(120),
                          height: ScreenTools.getSize(164),
                          fit: BoxFit.cover,
                        ),
                        Expanded(
                            child: Container(
                          margin:
                              EdgeInsets.only(left: ScreenTools.getSize(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                pp.videoInfo!.title!,
                                style: TextStyle(
                                    fontSize: ScreenTools.getSize(15)),
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: ScreenTools.getSize(5)),
                                  child: Text("时间: ${pp.videoInfo?.date}")),
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: ScreenTools.getSize(5)),
                                  child: Text("地区:${pp.videoInfo?.area}")),
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: ScreenTools.getSize(5)),
                                  child: Text("演员:${pp.videoInfo?.actor}")),
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: ScreenTools.getSize(5)),
                                  child: Text("类型:${pp.videoInfo?.type}")),
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: ScreenTools.fromSafeTop(5),
                  left: ScreenTools.getSize(10),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: Text("返回",
                        style: TextStyle(
                            fontSize: ScreenTools.getSize(15),
                            color: Colors.black)),
                    onTap: () {
                      p.backBtnClicked();
                    },
                  ),
                ),
                Positioned(
                  top: ScreenTools.fromSafeTop(200),
                  left: ScreenTools.getSize(18),
                  right: ScreenTools.getSize(18),
                  bottom: 0,
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    children: [
                      Text("${pp.videoInfo?.detail}"),
                      _diversityArea(p, pp)
                    ],
                  ),
                )
              ])));
  }

  Widget _diversityArea(VideoInfoProvider p, VideoInfoProvider pp) {
    return Container(
      margin: EdgeInsets.only(top: ScreenTools.getSize(20)),
      child: Wrap(
          spacing: ScreenTools.getSize(10),
          runSpacing: ScreenTools.getSize(10),
          children: [
            ...pp.videoInfo!.diversity!.map((e) {
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Container(
                  width: ScreenTools.getSize(100),
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenTools.getSize(5),
                      horizontal: ScreenTools.getSize(10)),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1)),
                  alignment: Alignment.center,
                  child: Text(
                    "${e.title}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            }).toList(),
          ]),
    );
  }
}
