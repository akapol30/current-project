import 'package:flutter/material.dart';
import 'package:project_towin/src/page/homepage.dart';
import 'package:project_towin/src/page/page1_northern.dart';
import 'package:project_towin/src/page/page2_northeastern.dart';
import 'package:project_towin/src/page/page3_western.dart';
import 'package:project_towin/src/page/page4_central.dart';
import 'package:project_towin/src/page/page5_eastern.dart';
import 'package:project_towin/src/page/page6_southern.dart';

class AppRoute {
  static const home = 'home';
  static const page1 = 'page1';
  static const page2 = 'page2';
  static const page3 = 'page3';
  static const page4 = 'page4';
  static const page5 = 'page5';
  static const page6 = 'page6';

  final _route = <String, WidgetBuilder>{
    home: (context) => const Home(),
    page1: (context) => const Page1(),
    page2: (context) => const Page2(),
    page3: (context) => const Page3(),
    page4: (context) => const Page4(),
    page5: (context) => const Page5(),
    page6: (context) => const Page6(),
  };

  get getAll => _route;
}
