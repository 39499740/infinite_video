/*
 * @Author: 郝怿
 * @Date: 2022-02-12 23:05:32
 * @LastEditTime: 2022-02-13 00:11:52
 * @LastEditors: 郝怿
 * @Description: 用户首页
 * @FilePath: /infinite_video/lib/pages/home/home/view.dart
 */

import 'package:auto_animated/auto_animated.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:infinite_video/common/screen_tools.dart';
import 'package:infinite_video/model/bumimi/home_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeProvider(context),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final p = context.read<HomeProvider>();
    final pp = Provider.of<HomeProvider>(context, listen: true);
    p.init();
    return Scaffold(
        body: pp.homeAreaDataList.isEmpty
            ? Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.grey, size: 35),
              )
            : SafeArea(
                child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: CustomScrollView(slivers: [
                  ...pp.homeAreaDataList.map((e) {
                    return _videoAreaWidget(e, p, pp);
                  }).toList()
                ]),
              )));
  }

  Widget _videoAreaWidget(BMMHome areaData, HomeProvider p, HomeProvider pp) {
    return SliverStickyHeader(
      header: Container(
        height: 60.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        color: Colors.white,
        alignment: Alignment.centerLeft,
        child: Text(
          areaData.title!,
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, i) => _videoWidget(areaData.videos![i], p, pp),
          childCount: areaData.videos!.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 15,
          childAspectRatio: 180 / 300,
        ),
      ),
    );
  }

  Widget _videoWidget(Videos video, HomeProvider p, HomeProvider pp) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AspectRatio(
            aspectRatio: 180 / 246.0,
            child: ExtendedImage.network(
              video.img!,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            video.title!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13, color: Colors.black),
          ),
          Text(
            video.subtitle!,
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
