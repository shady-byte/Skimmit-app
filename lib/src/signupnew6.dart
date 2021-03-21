import 'package:flutter/material.dart';
import 'package:graduation_project/classes/blocControl.dart';
import 'package:graduation_project/classes/validateMixin.dart';
import 'package:graduation_project/src/signupnew3.dart';

class SignUpNew6 extends StatefulWidget {
  createState() {
    return SignUpNew6State();
  }
}

class SignUpNew6State extends State<SignUpNew6> with VaildateMixin {
  List gender = ['Male', 'Female'];
  int selectedIndex = -1;
  String answer;
  bool choosen = false;

  Widget build(context) {
    var screenSize = MediaQuery.of(context).size;

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
                'We need some details about you to set your BMR and recommended calories intake.'),
            Positioned(
              top: screenSize.height * 0.29,
              child: Container(
                width: screenSize.width,
                height: screenSize.height * 0.08,
                //color: Colors.green,
                child: Center(
                  child: Text(
                    'Choose Gender',
                    style: TextStyle(
                      fontFamily: 'Bree Serif',
                      fontSize: 36,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenSize.height * 0.41,
              child: Container(
                width: screenSize.width,
                height: screenSize.height * 0.208,
                //color: Colors.red,
                child: Center(
                  child: Container(
                    width: screenSize.width * 0.865,
                    height: screenSize.height * 0.208,
                    //color: Colors.green,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: gender.length,
                      itemBuilder: (BuildContext context, int position) {
                        return InkWell(
                          onTap: () => setState(() {
                            selectedIndex = position;
                            answer = gender[position];
                          }),
                          child: Container(
                            width: 172,
                            height: 173,
                            //color: Colors.blue,
                            margin: EdgeInsets.only(right: 11),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selectedIndex == position
                                    ? colorChange('#4F2171')
                                    : colorChange('#EBEBEB'),
                                width: 4,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/gender${(gender[position]).toLowerCase()}.png',
                                  width: screenSize.width * 0.17,
                                  color: selectedIndex == position
                                      ? colorChange('#4F2171')
                                      : Colors.grey[400],
                                ),
                                Container(
                                  height: 15,
                                  width: 172,
                                ),
                                Text(
                                  '${gender[position]}',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: selectedIndex == position
                                        ? colorChange('#4F2171')
                                        : Colors.grey[600],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: screenSize.height * 0.18,
              child: Container(
                //color: Colors.green,
                width: screenSize.width,
                height: 50,
                child: Center(
                  child: Text(
                    choosen ? 'Please click on any gender above' : '',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: screenSize.height * 0.08,
              child: Container(
                width: screenSize.width,
                height: screenSize.height * 0.075,
                padding: EdgeInsets.only(
                    left: screenSize.width * 0.065,
                    right: screenSize.width * 0.065),
                //color: Colors.blue,
                child: RaisedButton(
                  onPressed: () {
                    if (answer != null) {
                      blocControl.setGender(answer.toLowerCase());
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => SignUpNew3()));
                    } else {
                      setState(() {
                        choosen = true;
                      });
                    }
                  },
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: screenSize.width * 0.9,
                    height: screenSize.height * 0.075,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(colors: [
                        colorChange('#CE1127'),
                        colorChange('#571E24')
                      ]),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
