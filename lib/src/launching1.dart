import 'package:flutter/material.dart';
import 'package:graduation_project/classes/transition.dart';
import 'package:graduation_project/src/launching2.dart';
import '../classes/validateMixin.dart';

class Launching1 extends StatefulWidget {
  createState() {
    return Launching1State();
  }
}

class Launching1State extends State<Launching1> with VaildateMixin {
  initState() {
    super.initState();
    launchingApp().then((value) {
      Navigator.of(context).pushReplacement(Transitions(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
        widget: Launching2(),
        transitionType: TransitionType.slideLeft,
      ));
    });
  }

  Widget build(context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorChange('#F9F9AF'),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: screenSize.height * 0.3,
              child: Container(
                margin: EdgeInsets.only(left: 5),
                width: 400,
                height: 400,
                child: Stack(
                  children: [
                    Positioned(
                      top: 40,
                      left: 40,
                      child: Container(
                        width: 320,
                        height: 320,
                        decoration: BoxDecoration(
                          color: Colors.yellow[100],
                          borderRadius: BorderRadius.circular(200),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      child: Image.asset(
                        'assets/images/back1.png',
                        width: 400,
                        height: 400,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: colorChange('#F9F9AF'),
                  borderRadius: BorderRadius.circular(200),
                ),
              ),
            ),
            Positioned(
              bottom: screenSize.height * 0.03,
              child: Container(
                width: screenSize.width,
                height: screenSize.height * 0.07,
                //color: Colors.red,
                child: Center(
                  child: Text(
                    'We are hooking you up....',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
