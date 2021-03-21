import 'package:flutter/material.dart';
import 'package:graduation_project/classes/validateMixin.dart';
import 'package:graduation_project/src/HomeScreen.dart';

class CategoriesScreen extends StatefulWidget {
  createState() {
    return CategoriesScreenState();
  }
}

class CategoriesScreenState extends State<CategoriesScreen> with VaildateMixin {
  var screenSize;

  Widget build(context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: screenSize.width,
                height: screenSize.height * 0.10,
                //color: Colors.green,
                child: Stack(
                  children: [
                    Positioned(
                      right: screenSize.width * -0.04,
                      child: Image.asset('assets/images/group.png',
                          width: 130, height: 130),
                    ),
                    Positioned(
                      left: 25,
                      child: Container(
                        width: screenSize.width * 0.875,
                        height: screenSize.height * 0.071,
                        margin: EdgeInsets.only(
                          top: screenSize.height * 0.02,
                          left: screenSize.width * 0.0,
                        ),
                        //color: Colors.red,
                        child: searchBar(context, screenSize),
                      ),
                    ),
                  ],
                ),
              ),
              title('Drinks', 'View All'),
              FutureBuilder(
                future: getCategoryProducts('drinks'),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            colorChange('#502171')),
                      ),
                    );
                  }
                  return itemCard(
                    screenSize,
                    snapshot.data,
                    true,
                  );
                },
              ),
              title('Meals', 'View All'),
              FutureBuilder(
                future: getCategoryProducts('meals'),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            colorChange('#502171')),
                      ),
                    );
                  }
                  return itemCard(
                    screenSize,
                    snapshot.data,
                    true,
                  );
                },
              ),
              title('Snacks', 'View All'),
              FutureBuilder(
                future: getCategoryProducts('snacks'),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            colorChange('#502171')),
                      ),
                    );
                  }
                  return itemCard(
                    screenSize,
                    snapshot.data,
                    true,
                  );
                },
              ),
              title('Canned', 'View All'),
              FutureBuilder(
                future: getCategoryProducts('canned'),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            colorChange('#502171')),
                      ),
                    );
                  }
                  return itemCard(
                    screenSize,
                    snapshot.data,
                    true,
                  );
                },
              ),
              Padding(padding: EdgeInsets.only(bottom: 20)),
            ],
          ),
        ),
      ),
    );
  }

  Widget title(String txt1, String txt2) {
    return Container(
      width: screenSize.width,
      height: screenSize.height * 0.038,
      padding: EdgeInsets.fromLTRB(29, 0.0, 29, 0.0),
      margin: EdgeInsets.only(top: screenSize.height * 0.01),
      //color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            txt1,
            style: TextStyle(
              fontSize: 23,
              fontFamily: 'Bree Serif',
              color: Colors.black,
            ),
          ),
          GestureDetector(
            child: Text(
              txt2,
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
                    currentState: txt1,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
