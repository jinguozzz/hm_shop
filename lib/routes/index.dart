// 管理路由
import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Login/index.dart';
import 'package:hm_shop/pages/Main/index.dart';

// 返回根组件
Widget getRootWidget() {
  return MaterialApp(routes: getRootRoutes());
}

// 配置路由
Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {'/': (context) => MainPage(), '/Login': (context) => LoginPage()};
}
