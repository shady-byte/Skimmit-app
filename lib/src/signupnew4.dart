import 'package:flutter/material.dart';
import 'package:graduation_project/classes/blocControl.dart';

import 'package:graduation_project/classes/validateMixin.dart';

class SignUpNew4 extends StatefulWidget {
  createState() {
    return SignUpNew4State();
  }
}

class SignUpNew4State extends State<SignUpNew4> with VaildateMixin {
  final formKey = GlobalKey<FormState>();

  Widget build(context) {
    var screenSize = MediaQuery.of(context).size;
    var keyboard = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            //color: Colors.red,
            width: screenSize.width,
            padding: EdgeInsets.only(
                left: screenSize.width * 0.05,
                right: screenSize.width * 0.057,
                bottom: 5),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(
                'assets/images/logo.png',
                width: 100,
                height: 35,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            titlePanel(screenSize, "BMR Setup for,", blocControl.name),
            formTitlePanel(screenSize,
                'We need some details about you to set your BMR and recommended calories intake'),
            inputPanel(screenSize, formKey, "What's your height?"),
            skipNowPanel(screenSize, context, 'height'),
            Positioned(
              bottom: keyboard == 0
                  ? screenSize.height * 0.08
                  : screenSize.height * 0.03,
              child: Container(
                width: screenSize.width,
                height: screenSize.height * 0.075,
                padding: EdgeInsets.only(
                    left: screenSize.width * 0.065,
                    right: screenSize.width * 0.065),
                //color: Colors.blue,
                child: nextButtonPanel(screenSize, formKey, context, 'height'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
