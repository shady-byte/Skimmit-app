import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_project/classes/blocControl.dart';
import 'package:graduation_project/src/mineralsScreen.dart';
import 'categoriesScreen.dart';
import 'categorySelect.dart';
import 'newItemScreen.dart';
import 'notUserScreen.dart';
import 'settingScreen.dart';
import 'userInfoScreen.dart';
import '../classes/validateMixin.dart';
import 'userHistory.dart';
import 'userPage.dart';

class HomeScreen extends StatefulWidget {
  final String currentState;
  HomeScreen({
    Key key,
    @required this.currentState,
  }) : super(key: key);

  createState() {
    return HomeScreenState(currentState);
  }
}

class HomeScreenState extends State<HomeScreen> with VaildateMixin {
  var screenSize;
  String _scanBarcode = '';
  int currentTab = 0;
  String firstLaunch;

  HomeScreenState(String cs) {
    switch (cs) {
      case 'history':
        currentTab = 2;
        break;
      case 'userInfo':
        currentTab = 4;
        break;
      case 'Snacks':
        currentTab = 7;
        break;
      case 'Drinks':
        currentTab = 10;
        break;
      case 'Meals':
        currentTab = 8;
        break;
      case 'Canned':
        currentTab = 9;
        break;
      case 'settings':
        currentTab = 6;
        break;
      case 'home':
        currentTab = 0;
        break;
    }
  }

  void initState() {
    userInfo(context, '70', 'no');
    storage.read(key: 'firstOpen').then((value) {
      if ((!blocControl.signedIn && currentTab == 6) || value == null) {
        Future.delayed(Duration(seconds: 0)).then((_) {
          bottomPopScreen(context, screenSize, 'page1');
        });
      }
    });

    storage.write(key: 'firstOpen', value: 'true');
    super.initState();
  }

  final List<Widget> screens = [
    UserPageScreen(),
    CategoriesScreen(),
    UserHistory(),
    SettingScreen(),
    UserInfoScreen(),
    MineralsScreen(),
    NotUserScreen(),
    CategorySelect(
      category: 'Snacks',
    ),
    CategorySelect(
      category: 'Meals',
    ),
    CategorySelect(
      category: 'Canned',
    ),
    CategorySelect(
      category: 'Drinks',
    ),
  ];
  final PageStorageBucket bucket = PageStorageBucket();

  Widget build(context) {
    screenSize = MediaQuery.of(context).size;
    //var keyboard = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      appBar: currentTab <= 6
          ? AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: screenSize.width,
                  padding: EdgeInsets.only(
                      left: screenSize.width * 0.05,
                      right: screenSize.width * 0.057),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 100,
                        height: 35,
                      ),
                      Spacer(),
                      userInfo(context, '1500', currentTab.toString()),
                    ],
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        child: Container(
          width: screenSize.width * 0.20,
          height: screenSize.width * 0.20,
          margin: EdgeInsets.only(
            bottom: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
          ),
          child: Center(
            child: Container(
              width: screenSize.width * 0.18,
              height: screenSize.width * 0.18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: LinearGradient(
                  colors: [colorChange('#CE1127'), colorChange('#571E24')],
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.linked_camera,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        onTap: scanBarcodeNormal,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: screenSize.height * 0.075,
          color: colorChange('#502171'),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 6),
                child: SizedBox.fromSize(
                  size: Size(70, 70), // button width and height
                  child: ClipOval(
                    child: Material(
                      color: colorChange('#502171'), // button color
                      child: InkWell(
                        splashColor: Colors.white38,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.home,
                              color: Colors.white,
                              size: 23,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3),
                              child: Text(
                                'Home',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Poppins-Regular',
                                ),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            currentTab = 0;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 70),
                child: SizedBox.fromSize(
                  size: Size(70, 70), // button width and height
                  child: ClipOval(
                    child: Material(
                      color: colorChange('#502171'), // button color
                      child: InkWell(
                        splashColor: Colors.white38,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/searchcategory.png',
                              width: 21,
                              height: 21,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                'Categories',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Poppins-Regular',
                                ),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            currentTab = 1;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: SizedBox.fromSize(
                  size: Size(70, 70),
                  child: ClipOval(
                    child: Material(
                      color: colorChange('#502171'),
                      child: InkWell(
                        splashColor: Colors.white38,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/minerals.png',
                              width: 22,
                              height: 22,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: Text(
                                'Minerals',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Poppins-Regular',
                                ),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            currentTab = 5;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 6),
                child: SizedBox.fromSize(
                  size: Size(70, 70),
                  child: ClipOval(
                    child: Material(
                      color: colorChange('#502171'),
                      child: InkWell(
                        splashColor: Colors.white38,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            blocControl.signedIn
                                ? Icon(
                                    Icons.settings,
                                    color: Colors.white,
                                    size: 22,
                                  )
                                : Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                            Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: blocControl.signedIn
                                  ? Text(
                                      'Settings',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: 'Poppins-Regular',
                                      ),
                                    )
                                  : Text(
                                      'Register',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: 'Poppins-Regular',
                                      ),
                                    ),
                            ),
                          ],
                        ),
                        onTap: () {
                          if (!blocControl.signedIn) {
                            setState(() {
                              currentTab = 6;
                            });
                            Future.delayed(Duration(seconds: 0)).then((_) {
                              bottomPopScreen(context, screenSize, 'page2');
                            });
                          } else {
                            setState(() {
                              currentTab = 3;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: currentTab,
        children: screens,
      ),
    );
  }

  scanBarcodeNormal() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#ff6666", "Cancel", true, ScanMode.BARCODE)
        .then((value) => setState(() => _scanBarcode = value));
    Fluttertoast.showToast(
      msg: 'searching for your product',
      backgroundColor: Colors.grey[700],
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
    var product = await getBarcodeProduct(_scanBarcode);
    Fluttertoast.cancel();
    if (product != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewItemScreen(product: product),
        ),
      );
    } else {
      Fluttertoast.showToast(
        msg: 'this product is not found',
        backgroundColor: Colors.grey[700],
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
}
