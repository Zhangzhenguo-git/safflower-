import 'package:flutter/material.dart';
import './navigator/tab_navigator.dart';
main() {
  runApp(safflower());
}

/**
 * 项目主入口
 */
class safflower extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hello word',
      home:TabNavigator()
    );
  }
}

