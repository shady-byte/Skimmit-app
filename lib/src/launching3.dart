import 'package:flutter/material.dart';
import '../classes/validateMixin.dart';

class Launching3 extends StatefulWidget {
  createState() {
    return Launching3State();
  }
}

class Launching3State extends State<Launching3> with VaildateMixin {
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
            child: Align(
              alignment: Alignment.bottomLeft,
              child: launchLogo(screenSize, context),
            ),
          ),
        ),
        backgroundColor: colorChange('#F6F7F9'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            launchImage(screenSize, 'assets/images/yoga.png'),
            launchTitle(screenSize,
                'Maintain a healthy diet by controlling your junk calories.'),
            launchTopic(
                screenSize,
                'We will help you keep track of your junk calories intake to maintain a healthy diet.',
                false),
            launchNextButton(screenSize, context, 'page2'),
          ],
        ),
      ),
    );
  }
}
