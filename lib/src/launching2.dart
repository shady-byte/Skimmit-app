import 'package:flutter/material.dart';
import '../classes/validateMixin.dart';

class Launching2 extends StatefulWidget {
  createState() {
    return Launching2State();
  }
}

class Launching2State extends State<Launching2> with VaildateMixin {
  Widget build(context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorChange('#F6F7F9'),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: screenSize.width,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: launchLogo(screenSize, context),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: colorChange('#F6F7F9'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            launchImage(screenSize, 'assets/images/icecream.png'),
            launchTitle(
                screenSize, 'Search and log your meal to count all calories'),
            launchTopic(
                screenSize,
                'You can search for any meal or snack you eat and log the calories you take.',
                false),
            launchNextButton(screenSize, context, 'page1'),
          ],
        ),
      ),
    );
  }
}
