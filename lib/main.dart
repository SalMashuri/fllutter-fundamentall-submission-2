import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sumission_2/pages/detail_page.dart';
import 'package:sumission_2/pages/homepage.dart';
import 'package:sumission_2/pages/search_page.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // initialBinding: ControllerBindings(),
      routes: {
        "/": (context) => Homepage(),
        // "/search": (context) => SearchPage()
      },
      // getPages: [GetPage(name: "/restaurant/:id", page: () => DetailPage())],
    );
  }
}
