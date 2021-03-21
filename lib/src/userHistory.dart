import 'package:flutter/material.dart';
import '../classes/validateMixin.dart';

class UserHistory extends StatefulWidget {
  createState() {
    return UserHistoryState();
  }
}

class UserHistoryState extends State<UserHistory> with VaildateMixin {
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
                //color: Colors.white,
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
              FutureBuilder(
                future: todayConsume(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: screenSize.height * 0.02,
                      ),
                      child: Text(''),
                    );
                  }
                  if (snapshot.data.length != 0) {
                    return Column(
                      children: [
                        title('Today', ''),
                        consumedItemCard(screenSize, snapshot.data, false),
                      ],
                    );
                  }
                  return Text('');
                },
              ),
              FutureBuilder(
                future: yesterdayConsume(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: screenSize.height * 0.02,
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              colorChange('#502171')),
                        ),
                      ),
                    );
                  }
                  if (snapshot.data.length != 0) {
                    return Column(
                      children: [
                        title('Yesterday', ''),
                        consumedItemCard(screenSize, snapshot.data, false),
                      ],
                    );
                  }
                  return Text('');
                },
              ),
              FutureBuilder(
                future: lastweekConsume(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: screenSize.height * 0.02,
                      ),
                      child: Text(''),
                    );
                  }
                  if (snapshot.data.length != 0) {
                    return Column(
                      children: [
                        title('Last Week', ''),
                        consumedItemCard(screenSize, snapshot.data, false),
                      ],
                    );
                  }
                  return Text('');
                },
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
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
      //color: Colors.white,
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
        ],
      ),
    );
  }
}
