import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:flutter_note/home_page.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColorLight: Color(0xFF6369B2),
        primaryColor: Color(0xFF070884),
        primaryColorDark: Color(0xFF060664),
        accentColor: Color(0xFFE33D24),
        fontFamily: 'Roboto',
      ),
      home: HomePage(),
    );
  }
}
