import 'package:flutter/material.dart';

import '../classes/validateMixin.dart';
import 'HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> with VaildateMixin {
  @override
  void initState() {
    checkConnection().then((value) {
      if (value == null) {
        getLoginTime().then((x) {
          if (x >= 167) {
            logOut();
          }
        });

        launchingApp().then((value) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  HomeScreen(currentState: 'other'),
            ),
          );
        });
      } else {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  value,
                  style: TextStyle(color: Colors.blue),
                ),
                actions: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      checkConnection().then((msg) {
                        if (msg == null) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (BuildContext context) => SplashScreen(),
                            ),
                          );
                        }
                      });
                    },
                    child: Text(
                      'Refresh',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              );
            });
      }
    });
    super.initState();
  }

  Widget build(context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(0.0, 0.27 * screenSize.height, 0.0, 0.0),
          child: Column(
            children: [
              Container(
                width: 0.65 * screenSize.width,
                height: 0.08 * screenSize.height,
                decoration: BoxDecoration(
                  //color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    43.0, 0.44 * screenSize.height, 43.0, 0.0),
                child: LinearProgressIndicator(
                  minHeight: 4.0,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  backgroundColor: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
