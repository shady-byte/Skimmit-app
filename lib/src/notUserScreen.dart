import 'package:flutter/material.dart';
import '../classes/validateMixin.dart';

class NotUserScreen extends StatefulWidget {
  createState() {
    return NotUserState();
  }
}

class NotUserState extends State<NotUserScreen> with VaildateMixin {
  var screenSize;

  Widget build(context) {
    screenSize = MediaQuery.of(context).size;
    var keyboard = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/user2.jpg',
                width: 400,
                height: 250,
              ),
              Padding(
                padding: EdgeInsets.only(left: 40, right: 40, bottom: 50),
                child: Text(
                  'Sign up to monitor your daily calories intake',
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'Bree Serif',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
