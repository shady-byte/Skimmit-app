import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../classes/blocControl.dart';
import '../classes/validateMixin.dart';
import 'HomeScreen.dart';

class UserPageScreen extends StatefulWidget {
  createState() {
    return UserPageState();
  }
}

class UserPageState extends State<UserPageScreen> with VaildateMixin {
  var screenSize;
  initState() {
    super.initState();
  }

  Widget build(context) {
    screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                //color: Colors.blue,
                width: screenSize.width,
                height: screenSize.height * 0.13,
                margin: EdgeInsets.only(top: screenSize.height * 0.02),
                padding: EdgeInsets.only(
                  left: screenSize.width * 0.065,
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Observer(
                        builder: (_) => Text(
                          blocControl.signedIn == true
                              ? 'Welcome back,'
                              : 'Monitor Now,',
                          style: TextStyle(
                            fontSize: 36,
                            fontFamily: 'Bree Serif',
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 0,
                      child: Observer(
                        builder: (_) => Text(
                          blocControl.signedIn == true
                              ? blocControl.name
                              : 'Your Calories',
                          style: TextStyle(
                            fontSize: 36,
                            fontFamily: 'Bree Serif',
                            color: colorChange('#4F2171'),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: screenSize.width * 0.02,
                      child: Image.asset('assets/images/group.png',
                          width: 130, height: 130),
                    ),
                  ],
                ),
              ),
              Container(
                width: screenSize.width * 0.875,
                height: screenSize.height * 0.071,
                margin: EdgeInsets.only(
                  top: screenSize.height * 0.03,
                  left: screenSize.width * 0.0,
                ),
                //color: Colors.red,
                child: searchBar(context, screenSize),
              ),
              Container(
                width: screenSize.width,
                height: screenSize.height * 0.12,
                margin: EdgeInsets.only(
                  top: screenSize.height * 0.034,
                ),
                //color: Colors.red,
                padding: EdgeInsets.only(left: 27.0, right: 27.0, top: 0.0),
                child: Row(
                  children: [
                    category('Drinks', 'assets/images/drinks.png'),
                    category('Meals', 'assets/images/meals.png'),
                    category('Snacks', 'assets/images/snacks.png'),
                    category('Canned', 'assets/images/canned.png'),
                  ],
                ),
              ),
              Container(
                width: screenSize.width,
                height: screenSize.height * 0.035,
                padding: EdgeInsets.fromLTRB(29, 0.0, 29, 0.0),
                margin: EdgeInsets.only(
                  top: screenSize.height * 0.04,
                ),
                //color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Latest Food',
                      style: TextStyle(
                        fontSize: 23,
                        fontFamily: 'Bree Serif',
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      child: Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins-SemiBold',
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              currentState: 'history',
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: todayConsume(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Padding(
                      padding: EdgeInsets.only(top: screenSize.height * 0.1),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            colorChange('#502171')),
                      ),
                    );
                  }
                  if (snapshot.data.length != 0) {
                    return consumedItemCard(screenSize, snapshot.data, false);
                  }
                  return Text(' ');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget category(String value, String image) {
    return GestureDetector(
      child: Container(
        width: screenSize.width * 0.185,
        height: screenSize.height * 0.15,
        margin: value == 'Canned'
            ? EdgeInsets.only(
                right: 0,
              )
            : EdgeInsets.only(
                right: 17,
              ),
        decoration: BoxDecoration(
          //color: Colors.grey,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: colorChange('#EBEBEB'),
            style: BorderStyle.solid,
            width: 2.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 42,
              height: 42,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: colorChange('#502171'),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              currentState: value,
            ),
          ),
        );
      },
    );
  }
}
