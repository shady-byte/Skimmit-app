import 'package:flutter/material.dart';
import 'src/splashScreen.dart';

class MyApp extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
