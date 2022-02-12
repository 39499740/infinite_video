/*
 * @Author: 郝怿
 * @Date: 2022-02-09 00:31:06
 * @LastEditTime: 2022-02-12 23:14:25
 * @LastEditors: 郝怿
 * @Description: 
 * @FilePath: /infinite_video/lib/main.dart
 */
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinite_video/crawler/home.dart';
import 'package:infinite_video/pages/home/home/view.dart';
import 'package:infinite_video/provider/main_provider.dart';
import 'package:provider/provider.dart';
import 'package:flustars/flustars.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => MainProvider())],
    child: const MyApp(),
  ));
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    setDesignWHD(375, 812);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        onGenerateRoute: (settings) {
          if (settings.name == '/') {
            return MaterialPageRoute(
                builder: (context) => HomePage(),
                settings: RouteSettings(name: settings.name));
          }
        });
  }
}
