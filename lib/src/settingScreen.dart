import 'package:flutter/material.dart';
import 'package:graduation_project/classes/transition.dart';
import 'package:graduation_project/src/editAgeScreen.dart';
import 'package:graduation_project/src/editHeightSCreen.dart';
import 'package:graduation_project/src/editNameScreen.dart';
import 'package:graduation_project/src/editPasswordScreen.dart';
import 'package:graduation_project/src/editWeightScreen.dart';
import '../classes/validateMixin.dart';
import 'HomeScreen.dart';

class SettingScreen extends StatelessWidget with VaildateMixin {
  var screenSize;
  Widget build(context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: screenSize.width,
          height: screenSize.height * 0.815,
          padding: EdgeInsets.only(
              left: screenSize.width * 0.05, right: screenSize.width * 0.05),
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, left: 0, bottom: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'Bree Serif',
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              changePanel('Name', context),
              linePanel(),
              changePanel('Password', context),
              linePanel(),
              changePanel('Height', context),
              linePanel(),
              changePanel('Weight', context),
              linePanel(),
              changePanel('Age', context),
              linePanel(),
              GestureDetector(
                onTap: () async {
                  await logOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(
                        currentState: 'home',
                      ),
                    ),
                  );
                },
                child: Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: screenSize.height * 0.08,
                    width: screenSize.width,
                    child: Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        'Log Out',
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Bree Serif',
                          color: Colors.red[700],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget changePanel(String value, BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (value) {
          case 'Name':
            Navigator.of(context).push(Transitions(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeIn,
              reverseCurve: Curves.easeOut,
              widget: EditNameScreen(),
              transitionType: TransitionType.slideLeft,
            ));
            break;
          case 'Password':
            Navigator.of(context).push(Transitions(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeIn,
              reverseCurve: Curves.easeOut,
              widget: EditPasswordScreen(),
              transitionType: TransitionType.slideLeft,
            ));
            break;
          case 'Height':
            Navigator.of(context).push(Transitions(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeIn,
              reverseCurve: Curves.easeOut,
              widget: EditHeightScreen(),
              transitionType: TransitionType.slideLeft,
            ));
            break;
          case 'Weight':
            Navigator.of(context).push(Transitions(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeIn,
              reverseCurve: Curves.easeOut,
              widget: EditWeightScreen(),
              transitionType: TransitionType.slideLeft,
            ));
            break;
          case 'Age':
            Navigator.of(context).push(Transitions(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeIn,
              reverseCurve: Curves.easeOut,
              widget: EditAgeScreen(),
              transitionType: TransitionType.slideLeft,
            ));
            break;
        }
      },
      child: Container(
        height: screenSize.height * 0.08,
        width: screenSize.width,
        color: Colors.white,
        child: Row(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 21,
                fontFamily: 'Bree Serif',
                color: Colors.black,
              ),
            ),
            Spacer(),
            Container(
              child: Row(
                children: [
                  Text(
                    'Change',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget linePanel() {
    return Container(
      width: screenSize.width,
      height: screenSize.height * 0.001,
      color: Colors.grey[300],
    );
  }
}
