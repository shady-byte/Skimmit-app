import 'package:flutter/material.dart';
import '../classes/validateMixin.dart';

class Launching4 extends StatefulWidget {
  createState() {
    return Launching4State();
  }
}

class Launching4State extends State<Launching4> with VaildateMixin {
  initState() {
    super.initState();
  }

  Widget build(context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorChange('#DE9699'),
      appBar: AppBar(
        leading: Container(),
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
        backgroundColor: colorChange('#DE9699'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            launchImage(screenSize, 'assets/images/wine.png'),
            launchTitle(screenSize,
                'Scan bar-code to quickly find the product and log your calories.'),
            launchTopic(
                screenSize,
                "Using our scan feature, you can easily scan the product's bar-code to find it and log your intake.",
                true),
            launchNextButton(screenSize, context, 'page3'),
          ],
        ),
      ),
    );
  }
}
