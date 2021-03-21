import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_project/classes/blocControl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:connectivity/connectivity.dart';
import 'package:string_validator/string_validator.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../classes/transition.dart';
import '../src/newItemScreen.dart';
import '../src/newSearchScreen.dart';
import '../src/popScreen.dart';
import '../src/userInfoScreen.dart';
import '../src/signupnew2.dart';
import '../src/signupnew4.dart';
import '../src/signupnew5.dart';
import '../src/signupnew6.dart';
import '../src/HomeScreen.dart';
import '../src/launching1.dart';
import '../src/launching3.dart';
import '../src/launching4.dart';
import 'consumedProduct.dart';
import 'product.dart';

class VaildateMixin {
  var password = '';
  String apMessage = '';
  String msg;
  final storage = new FlutterSecureStorage();

  String validateEmail(String value) {
    if (!isEmail(value)) return 'Please enter a valid email';

    return null;
  }

  String validatePass(String value) {
    if (value.length < 8) return 'Password is at least 8 characters';

    password = value;
    return null;
  }

  String confirmPass(String value) {
    if (value != password || value.isEmpty)
      return 'make sure you entered the same password';

    return null;
  }

  String validateAge(String value) {
    if (value.length == 0 || !isNumeric(value)) {
      isNumeric(value);
      return 'please enter your age';
    }
    int x = int.parse(value);
    if (!(isInt(value) && x >= 15 && x <= 80) || value.length == 0)
      return x < 15
          ? 'you are below the minimum age'
          : 'you are over the maximum age';

    return null;
  }

  bool isNumeric(String num) {
    for (int i = 0; i < num.length; i++) {
      if (!isInt(num[i])) {
        return false;
      }
    }
    return true;
  }

  String validateName(String value) {
    String result = '';
    var fullName = value.split(' ');
    if (fullName.length > 5 ||
        value.isEmpty ||
        value.length > 30 ||
        value.length < 3) {
      return 'please enter a correct name';
    }
    return null;
  }

  String validateHeight(String value) {
    if (value.length == 0 || !isFloat(value)) {
      return 'please enter your height';
    }
    double x = double.parse(value);
    if (!(isFloat(value) && x > 50 && x < 300))
      return 'please enter a proper height';

    return null;
  }

  String validateWeight(String value) {
    if (value.length == 0 || !isFloat(value)) {
      return 'please enter your weight';
    }
    double x = double.parse(value);
    if (!(isFloat(value) && x > 20 && x < 300))
      return 'please enter a proper weight';

    return null;
  }

  String validateQuantity(String value) {
    if (value.length == 0) {
      return 'please enter a quantity';
    }
    int x = int.parse(value);
    if (!(isInt(value) && x > 0)) return 'please enter a valid quantity';

    return null;
  }

  Widget logoPanel(var screenSize) {
    return Positioned(
      top: screenSize.height * 0.05,
      child: Container(
        //color: Colors.red,
        width: screenSize.width,
        height: screenSize.height * 0.07,
        padding: EdgeInsets.only(
            left: screenSize.width * 0.065, right: screenSize.width * 0.057),
        child: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 110,
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget titlePanel(var screenSize, String title1, String title2) {
    return Positioned(
      top: screenSize.height * 0.02,
      child: Container(
        //color: Colors.blue,
        width: screenSize.width,
        height: screenSize.height * 0.15,
        padding: EdgeInsets.only(
          left: screenSize.width * 0.065,
        ),
        child: Stack(
          children: [
            Positioned(
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  title1,
                  style: TextStyle(
                    fontSize: 36,
                    fontFamily: 'Bree Serif',
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenSize.height * 0.059,
              child: Text(
                title2,
                style: TextStyle(
                  fontSize: 36,
                  fontFamily: 'Bree Serif',
                  color: colorChange('#4F2171'),
                ),
              ),
            ),
            Positioned(
              bottom: screenSize.height * 0.02,
              right: screenSize.width * 0.02,
              child: Image.asset('assets/images/group.png',
                  width: 130, height: 130),
            ),
          ],
        ),
      ),
    );
  }

  Widget formTitlePanel(var screenSize, title) {
    return Positioned(
      top: screenSize.height * 0.17,
      child: Container(
        height: screenSize.height * 0.06,
        width: screenSize.width,
        padding: EdgeInsets.only(
            left: screenSize.width * 0.065, right: screenSize.width * 0.1),
        //color: Colors.red,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins',
            color: colorChange('#878787'),
          ),
        ),
      ),
    );
  }

  Widget inputField(String hint, String state) {
    return TextFormField(
      keyboardType: TextInputType.number,
      cursorColor: colorChange('#4F2171'),
      autofocus: true,
      decoration: InputDecoration(
        prefix: Padding(padding: EdgeInsets.only(left: 20)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(90.0)),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(
          color: colorChange('#878787'),
          fontFamily: 'Poppins',
        ),
        filled: true,
        fillColor: colorChange('F4F4F4'),
        hintText: hint,
        suffix: Padding(
          padding: EdgeInsets.only(right: 20),
          child: Text(
            hint.contains('height')
                ? 'CM'
                : hint.contains('weight')
                    ? 'KG'
                    : '',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      validator: hint.contains('age')
          ? validateAge
          : hint.contains('height')
              ? validateHeight
              : hint.contains('weight')
                  ? validateWeight
                  : validateName,
      onSaved: (value) async {
        if (state == null) {
          hint.contains('age')
              ? blocControl.setAge(int.parse(value))
              : hint.contains('height')
                  ? blocControl.setHeight(double.parse(value))
                  : hint.contains('weight')
                      ? blocControl.setWeight(double.parse(value))
                      : null;
        } else {
          await updatePersonalData(hint, value);
          await launchingApp();
        }
      },
    );
  }

  Widget inputPanel(var screenSize, var formKey, String hint, {String state}) {
    return Positioned(
      top: screenSize.height * 0.265,
      child: Container(
        width: screenSize.width,
        height: screenSize.height * 0.11,
        padding: EdgeInsets.only(
            left: screenSize.width * 0.065, right: screenSize.width * 0.065),
        //color: Colors.blue,
        child: Form(
          key: formKey,
          child: inputField(hint, state != null ? state : null),
        ),
      ),
    );
  }

  Widget nextButtonPanel(
    var screenSize,
    var formKey,
    BuildContext context,
    String title,
  ) {
    return RaisedButton(
      onPressed: () async {
        if (formKey.currentState.validate()) {
          await formKey.currentState.save();
          switch (title) {
            case 'email':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignUpNew2()),
              );
              break;
            case 'pass':
              await sendPersonalData();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignUpNew6()),
              );
              break;
            case 'age':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignUpNew4()),
              );
              break;
            case 'height':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignUpNew5()),
              );
              break;
            case 'weight':
              bool x = await sendpatchProfile();
              if (x) {
                Navigator.of(context).pushReplacement(Transitions(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                  reverseCurve: Curves.easeOut,
                  widget: Launching1(),
                  transitionType: TransitionType.slideLeft,
                ));
              } else {
                Fluttertoast.showToast(
                  msg:
                      'something went wrong,your can add your BMR values later',
                  backgroundColor: Colors.grey[700],
                  textColor: Colors.white,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                );
                Navigator.of(context).pushReplacement(Transitions(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                  reverseCurve: Curves.easeOut,
                  widget: Launching1(),
                  transitionType: TransitionType.slideLeft,
                ));
              }

              break;
            default:
              checkConnection().then((msg) {
                if (msg != null) {
                  Fluttertoast.showToast(
                    msg: "you need to be connected to internet",
                    backgroundColor: Colors.grey[700],
                    textColor: Colors.white,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                }
              });
              launchingApp().then((value) {
                Navigator.of(context).pop();
              });
              break;
          }
        }
      },
      padding: const EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        width: screenSize.width * 0.9,
        height: screenSize.height * 0.075,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
              colors: [colorChange('#CE1127'), colorChange('#571E24')]),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  Widget skipNowPanel(var screenSize, BuildContext context, String value) {
    return Positioned(
      top: screenSize.height * 0.364,
      child: Container(
        width: screenSize.width,
        height: screenSize.height * 0.03,
        padding: EdgeInsets.only(
          left: screenSize.width * 0.54,
          right: screenSize.width * 0.065,
        ),
        //color: Colors.green,
        child: SizedBox(
          width: 60,
          height: 70,
          child: FlatButton.icon(
            icon: Icon(Icons.subdirectory_arrow_right),
            label: Text(
              'Skip for now',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Poppins',
              ),
            ),
            onPressed: () async {
              bool x = await sendpatchProfile();
              if (x) {
                Navigator.of(context).pushReplacement(Transitions(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                  reverseCurve: Curves.easeOut,
                  widget: Launching1(),
                  transitionType: TransitionType.slideLeft,
                ));
              } else {
                Fluttertoast.showToast(
                  msg:
                      'something went wrong,your can add your BMR values later',
                  backgroundColor: Colors.grey[700],
                  textColor: Colors.white,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                );
                Navigator.of(context).pushReplacement(Transitions(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                  reverseCurve: Curves.easeOut,
                  widget: Launching1(),
                  transitionType: TransitionType.slideLeft,
                ));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget launchLogo(var screenSize, BuildContext context) {
    return Container(
      //color: Colors.red,
      width: screenSize.width,
      height: screenSize.height * 0.07,
      padding: EdgeInsets.only(
          left: screenSize.width * 0.065, right: screenSize.width * 0.038),
      child: Row(
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: screenSize.width * 0.23,
            //screenSize.width * 0.267
            height: 35,
          ),
          Padding(
            padding: EdgeInsets.only(left: screenSize.width * 0.398),
            child: SizedBox(
              width: screenSize.width * 0.245,
              height: screenSize.height * 0.06,
              child: FlatButton.icon(
                icon: Icon(
                  Icons.close,
                  size: 20,
                ),
                label: Text(
                  'Close',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(
                              currentState: 'other',
                            )),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget launchImage(var screenSize, String image) {
    return Positioned(
      top: screenSize.height * 0.1,
      child: Container(
        width: screenSize.width,
        height: screenSize.height * 0.4,
        //color: Colors.red,
        child: Image.asset(image),
      ),
    );
  }

  Widget launchTitle(var screenSize, String text) {
    return Positioned(
      top: screenSize.height * 0.52,
      child: Container(
        width: screenSize.width,
        height: screenSize.height * 0.17,
        //color: Colors.red,
        padding: EdgeInsets.only(
          left: 35,
          right: 35,
        ),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
            fontSize: 28,
            fontFamily: 'Bree Serif',
          ),
          textAlign: TextAlign.center,
        )),
      ),
    );
  }

  Widget launchTopic(var screenSize, String text, bool option) {
    return Positioned(
      top: screenSize.height * 0.69,
      child: Container(
        width: screenSize.width,
        height: screenSize.height * 0.077,
        //color: Colors.red,
        padding: EdgeInsets.only(
          left: 45,
          right: 45,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
              color: option ? Colors.white : colorChange('#878787'),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget launchNextButton(var screenSize, BuildContext context, String action) {
    return Positioned(
      bottom: screenSize.height * 0.05,
      child: Container(
        width: screenSize.width,
        height: screenSize.height * 0.06,
        //color: Colors.red,
        child: Center(
          child: SizedBox(
            width: screenSize.width * 0.37,
            height: screenSize.height * 0.06,
            child: FlatButton.icon(
              icon: Icon(
                Icons.subdirectory_arrow_right,
                color:
                    action == 'page3' ? Colors.white : colorChange('#4F2171'),
              ),
              label: Text(
                'Okay,Next',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color:
                      action == 'page3' ? Colors.white : colorChange('#4F2171'),
                ),
              ),
              onPressed: () {
                switch (action) {
                  case 'page1':
                    Navigator.of(context).pushReplacement(Transitions(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                      reverseCurve: Curves.easeOut,
                      widget: Launching3(),
                      transitionType: TransitionType.slideLeft,
                    ));
                    break;
                  case 'page2':
                    Navigator.of(context).pushReplacement(Transitions(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                      reverseCurve: Curves.easeOut,
                      widget: Launching4(),
                      transitionType: TransitionType.slideLeft,
                    ));
                    break;
                  case 'page3':
                    Navigator.of(context).pushReplacement(Transitions(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                      reverseCurve: Curves.easeOut,
                      widget: HomeScreen(currentState: 'other'),
                      transitionType: TransitionType.slideLeft,
                    ));
                    break;
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget itemCard(var screenSize, List<Product> items, bool category) {
    return Container(
      width: screenSize.width,
      height: screenSize.height * 0.29,
      padding: EdgeInsets.only(
        left: 27,
        top: 16,
      ),
      //color: Colors.blue,
      child: ListView.builder(
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Container(
              width: screenSize.width * 0.425,
              margin: EdgeInsets.only(right: 11),
              decoration: BoxDecoration(
                color: colorChange('#F1F4EB'),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 13,
                    right: 14,
                    child: category == false
                        ? Text(
                            '0',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: colorChange('#545651')),
                          )
                        : Text(''),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenSize.height * 0.051,
                      left: screenSize.width * 0.097,
                    ),
                    child: Image.network(
                      url + items[index].imageurl,
                      width: screenSize.width * 0.250,
                      height: screenSize.width * 0.250,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: screenSize.height * 0.1, right: 10, left: 10),
                    child: Center(
                      child: Text(
                        items[index].name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Bree Serif',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenSize.height * 0.21,
                      left: screenSize.width * 0.15,
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/images/flame.png',
                            width: 12, height: 12),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            (items[index].meta['calories']).toString(),
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Poppins-SemiBold',
                              fontWeight: FontWeight.w600,
                              color: colorChange('#545651'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: screenSize.height * 0.235,
                        left: screenSize.width * 0.185),
                    child: Container(
                      width: screenSize.width * 0.068,
                      height: screenSize.width * 0.068,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.of(context).push(Transitions(
                duration: Duration(milliseconds: 200),
                curve: Curves.bounceInOut,
                reverseCurve: Curves.fastOutSlowIn,
                transitionType: TransitionType.slideUp,
                widget: NewItemScreen(product: items[index]),
              ));
            },
          );
        },
      ),
    );
  }

  Widget consumedItemCard(
      var screenSize, List<ConsumedProduct> items, bool category) {
    return Container(
      width: screenSize.width,
      height: screenSize.height * 0.29,
      padding: EdgeInsets.only(
        left: 27,
        top: 16,
      ),
      //color: Colors.blue,
      child: ListView.builder(
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return FutureBuilder(
            future: getBarcodeProduct(items[index].barcode.toString()),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Text(' ');
              }
              return GestureDetector(
                child: Container(
                  width: screenSize.width * 0.425,
                  margin: EdgeInsets.only(right: 11),
                  decoration: BoxDecoration(
                    color: colorChange('#F1F4EB'),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 13,
                        right: 14,
                        child: Text(
                          items[index].quantity.toString(),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: colorChange('#545651')),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenSize.height * 0.051,
                          left: screenSize.width * 0.097,
                        ),
                        child: Image.network(
                          url + snapshot.data.imageurl,
                          width: screenSize.width * 0.260,
                          height: screenSize.width * 0.260,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: screenSize.height * 0.1, right: 10, left: 10),
                        child: Center(
                          child: Text(
                            items[index].name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Bree Serif',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenSize.height * 0.21,
                          left: screenSize.width * 0.15,
                        ),
                        child: Row(
                          children: [
                            Image.asset('assets/images/flame.png',
                                width: 12, height: 12),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                (snapshot.data.meta['calories']).toString(),
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Poppins-SemiBold',
                                  fontWeight: FontWeight.w600,
                                  color: colorChange('#545651'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: screenSize.height * 0.235,
                            left: screenSize.width * 0.185),
                        child: Container(
                          width: screenSize.width * 0.068,
                          height: screenSize.width * 0.068,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            size: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  getBarcodeProduct(items[index].barcode.toString())
                      .then((value) {
                    if (value != null) {
                      Navigator.of(context).push(Transitions(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.bounceInOut,
                        reverseCurve: Curves.fastOutSlowIn,
                        transitionType: TransitionType.slideUp,
                        widget: NewItemScreen(product: value),
                      ));
                    } else {
                      Fluttertoast.showToast(
                        msg: 'you need to be connected to internet',
                        backgroundColor: Colors.grey[700],
                        textColor: Colors.white,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                      );
                    }
                  });
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget searchBar(BuildContext context, var screenSize) {
    return TextField(
      onTap: () {
        Navigator.of(context).push(Transitions(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeIn,
          reverseCurve: Curves.easeOut,
          widget: NewSearchScreen(),
          transitionType: TransitionType.slideUp,
        ));
      },
      cursorColor: colorChange('#4F2171'),
      style: TextStyle(
        fontSize: 17.0,
      ),
      readOnly: true,
      decoration: InputDecoration(
        fillColor: colorChange('F4F4F4'),
        filled: true,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: Icon(Icons.search, size: 23, color: Colors.black),
          ),
        ),
        suffixIcon: Container(
          margin: EdgeInsets.all(10.0),
          width: screenSize.width * 0.1,
          height: screenSize.width * 0.1,
        ),
        hintText: 'What are you looking for ?',
        contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        hintStyle: TextStyle(
            fontSize: 15.0,
            fontFamily: 'Poppins-Medium',
            color: colorChange('#878787')),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(90.0)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget userInfo(BuildContext context, String value, String state) {
    return GestureDetector(
      child: blocControl.signedIn
          ? FutureBuilder(
              future: dailyCalories('today'),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Text(' ');
                }
                return blocControl.signedIn &&
                        snapshot.data != null &&
                        blocControl.bmr != 0
                    ? CircularPercentIndicator(
                        radius: 50,
                        circularStrokeCap: CircularStrokeCap.round,
                        lineWidth: 4,
                        percent: calculatePercent(
                            snapshot.data != null ? snapshot.data : '0',
                            'today'),
                        progressColor: colorChange('#8727CE'),
                        backgroundColor: Colors.white,
                        animation: true,
                        animationDuration: 700,
                        center: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(
                              'assets/images/${blocControl.gender}.png'),
                          radius: 18,
                        ),
                      )
                    : CircularPercentIndicator(
                        radius: 50,
                        circularStrokeCap: CircularStrokeCap.round,
                        lineWidth: 4,
                        percent: 0.0,
                        progressColor: colorChange('#8727CE'),
                        backgroundColor: Colors.white,
                        animation: true,
                        animationDuration: 700,
                        center: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(
                              'assets/images/${blocControl.gender}.png'),
                          radius: 18,
                        ),
                      );
              },
            )
          : CircularPercentIndicator(
              radius: 50,
              circularStrokeCap: CircularStrokeCap.round,
              lineWidth: 4,
              percent: 0.0,
              progressColor: colorChange('#8727CE'),
              backgroundColor: Colors.white,
              animation: true,
              animationDuration: 700,
              center: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage:
                    AssetImage('assets/images/${blocControl.gender}.png'),
                radius: 18,
              ),
            ),
      onTap: () {
        if (blocControl.signedIn && blocControl.bmr != 0) {
          if (state != '4') {
            Navigator.of(context).push(Transitions(
              duration: Duration(milliseconds: 200),
              curve: Curves.bounceInOut,
              reverseCurve: Curves.bounceOut,
              transitionType: TransitionType.scale,
              widget: HomeScreen(
                currentState: 'userInfo',
              ),
            ));
          } else {
            Navigator.of(context).pop();
          }
        }
      },
    );
  }

  void bottomPopScreen(BuildContext context, Size screenSize, String page) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Padding(
          padding: EdgeInsets.only(bottom: 0),
          //MediaQuery.of(context).viewInsets
          child: SingleChildScrollView(
            child: page == 'page1'
                ? Page1(
                    screenSize: screenSize,
                    currentView: 0,
                  )
                : Page1(
                    screenSize: screenSize,
                    currentView: 1,
                  ),
          ),
        );
      },
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  Color colorChange(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }

  Future<bool> sendPersonalData() async {
    final String apiUrl = "https://mondelez-api.herokuapp.com/users/signup";
    var conn = await checkConnection();
    try {
      if (conn == null) {
        final response = await http.post(apiUrl,
            body: jsonEncode({
              "name": blocControl.name,
              "email": blocControl.email,
              "password": blocControl.password,
              "confirm_password": blocControl.password,
            }),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            });
        var resBody = json.decode(response.body);
        if (resBody['success'] == true) {
          blocControl.setToken(resBody['token']);
          blocControl.setSignIn(true);
          await storage.write(key: 'token', value: resBody['token']);
          await storage.write(key: 'date', value: getCurrentDate());
          return true;
        }
        throw 'result was false';
      } else {
        throw 'no connection';
      }
    } catch (err) {
      return null;
    }
  }

  Future<bool> sendpatchProfile() async {
    final String apiUrl = "https://mondelez-api.herokuapp.com/users";
    Map<String, dynamic> body = {};

    if (blocControl.age != 0) body['age'] = blocControl.age;
    if (blocControl.height != 0) body['height'] = blocControl.height;
    if (blocControl.weight != 0) body['weight'] = blocControl.weight;
    if (blocControl.gender != null) body['gender'] = blocControl.gender;
    var conn = await checkConnection();
    try {
      if (conn == null) {
        final response = await http
            .patch(apiUrl, body: jsonEncode(body), headers: <String, String>{
          'Authorization': 'Bearer ${blocControl.token}',
          'Content-Type': 'application/json; charset=UTF-8'
        });
        var resBody = json.decode(response.body);
        if (resBody['success'] == true) {
          return true;
        }
        throw 'result is false';
      } else {
        throw 'no connection';
      }
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<bool> updatePersonalData(String hint, String value) async {
    final String apiUrl = "https://mondelez-api.herokuapp.com/users";
    Map<String, dynamic> body = {};
    if (hint.contains('age'))
      body['age'] = int.parse(value);
    else if (hint.contains('name'))
      body['name'] = value;
    else if (hint.contains('height'))
      body['height'] = double.parse(value);
    else if (hint.contains('weight')) body['weight'] = double.parse(value);
    var conn = await checkConnection();
    try {
      if (conn == null) {
        final response = await http
            .patch(apiUrl, body: jsonEncode(body), headers: <String, String>{
          'Authorization': 'Bearer ${blocControl.token}',
          'Content-Type': 'application/json; charset=UTF-8'
        });
        var resBody = jsonDecode(response.body);
        if (resBody['success'] == true) {
          List<String> name = value.split(' ');
          if (body.containsKey('name')) blocControl.setName(name[0]);
          if (body.containsKey('age')) blocControl.setAge(int.parse(value));
          if (body.containsKey('height'))
            blocControl.setHeight(double.parse(value));
          if (body.containsKey('weight'))
            blocControl.setWeight(double.parse(value));
          return resBody['success'];
        }
        throw 'result is false';
      } else {
        throw ('no connection');
      }
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<String> loginApi(String email, password) async {
    final String apiUrl = "https://mondelez-api.herokuapp.com/users/signin";
    var conn = await checkConnection();
    try {
      if (conn == null) {
        final response = await http.post(apiUrl,
            body: jsonEncode({
              "email": email,
              "password": password,
            }),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            });
        var resBody = json.decode(response.body);
        if (resBody['success'] == true) {
          blocControl.setToken(resBody['token']);
          await storage.write(key: 'token', value: resBody['token']);
          await storage.write(key: 'date', value: getCurrentDate());
        }
        return resBody['message'];
      } else {
        Fluttertoast.showToast(
          msg: "you need to be connected to internet",
          backgroundColor: Colors.grey[700],
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<Map<String, dynamic>> launchingApp() async {
    final String apiUrl = "https://mondelez-api.herokuapp.com/users/profile";
    String token = await storage.read(key: 'token');
    if (token != null) {
      blocControl.setToken(token);
    }
    try {
      var conn = await checkConnection();
      if (conn == null) {
        var response = await http.get(apiUrl, headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        });
        var resBody = jsonDecode(response.body);
        if (resBody['success'] == true) {
          blocControl.setGender(resBody['data']['meta']['gender']);
          blocControl
              .setBmr(double.parse(resBody['data']['meta']['BMR'].toString()));
          List<String> name = (resBody['data']['name']).split(' ');
          blocControl.setName(name[0]);
          blocControl.setSignIn(true);
          return resBody['data'];
        }
        throw 'the result was false';
      } else {
        throw 'no internet connection';
      }
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<String> resetPassword(String old, pass, confirm) async {
    final String apiUrl =
        "https://mondelez-api.herokuapp.com/users/password/reset";
    Map<String, dynamic> body = {
      "old_password": old,
      "new_password": pass,
      "confirm_password": confirm,
    };
    var conn = await checkConnection();
    try {
      if (conn == null) {
        final response = await http
            .post(apiUrl, body: jsonEncode(body), headers: <String, String>{
          'Authorization': 'Bearer ${blocControl.token}',
          'Content-Type': 'application/json; charset=UTF-8'
        });
        var resBody = jsonDecode(response.body);
        return resBody['message'];
      } else {
        throw 'no connection';
      }
    } catch (err) {
      print(err);
      return null;
    }
  }

  void logOut() {
    storage.delete(key: 'token');
    storage.delete(key: 'date');
    blocControl.setToken(null);
    blocControl.setSignIn(false);
    blocControl.setGender('male');
    blocControl.setBmr(0);
    blocControl.setHeight(0);
    blocControl.setWeight(0);
    blocControl.setAge(0);
  }

  String getCurrentDate() {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day, now.hour);
    return date.toString();
  }

  Future<int> getLoginTime() async {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day, now.hour);
    return storage.read(key: 'date').then((value) {
      if (value != null) {
        return (date.difference(DateTime.parse(value)).inHours).toInt();
      } else {
        return -1;
      }
    });
  }

  Future<List<Product>> getCategoryProducts(String category) async {
    final String apiUrl =
        "https://mondelez-api.herokuapp.com/products/category/$category";
    List<Product> products = [];
    bool x = true;
    int i = 1;
    var conn = await checkConnection();
    try {
      if (conn == null) {
        while (x) {
          final response =
              await http.get(apiUrl + '?page=$i', headers: <String, String>{
            'Authorization': 'Bearer ${blocControl.token}',
            'Content-Type': 'application/json; charset=UTF-8'
          });
          var resBody = jsonDecode(response.body);
          if (resBody['success'] == true) {
            products += resBody['data']
                .map<Product>((item) => Product.list(item))
                .toList();
          } else {
            x = false;
          }
          i++;
        }
        return products;
      } else {
        throw 'no connection';
      }
    } catch (err) {
      print(err);
      return products;
    }
  }

  Future<Product> getBarcodeProduct(String barcode) async {
    final String apiUrl =
        "https://mondelez-api.herokuapp.com/products/$barcode";
    var conn = await checkConnection();
    try {
      if (conn == null) {
        final response = await http.get(apiUrl, headers: <String, String>{
          'Authorization': 'Bearer ${blocControl.token}',
          'Content-Type': 'application/json; charset=UTF-8'
        });
        var resBody = jsonDecode(response.body);
        if (resBody['success'] == true) {
          Product product = Product.list(resBody['data']);
          return product;
        }
        throw 'result is false';
      } else {
        throw 'no connection';
      }
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<String> consumeProduct(int barcode, int quantity) async {
    final String apiUrl = "https://mondelez-api.herokuapp.com/consume";
    final Map<String, dynamic> body = {
      "barcode": barcode,
      "quantity": quantity,
    };
    var conn = await checkConnection();
    try {
      if (conn == null) {
        final response = await http
            .post(apiUrl, body: jsonEncode(body), headers: <String, String>{
          'Authorization': 'Bearer ${blocControl.token}',
          'Content-Type': 'application/json; charset=UTF-8'
        });
        var resBody = jsonDecode(response.body);
        return resBody['message'];
      } else {
        throw 'no connection';
      }
    } catch (err) {
      print(err);
      return 'no connection';
    }
  }

  Future<List<ConsumedProduct>> todayConsume() async {
    final String apiUrl = "https://mondelez-api.herokuapp.com/consume/today";
    List<ConsumedProduct> products = [];
    var conn = await checkConnection();
    try {
      if (conn == null) {
        final response = await http.get(apiUrl, headers: <String, String>{
          'Authorization': 'Bearer ${blocControl.token}',
          'Content-Type': 'application/json; charset=UTF-8'
        });
        var resBody = jsonDecode(response.body);
        if (resBody['success'] == true) {
          products = resBody['data']['products']
              .map<ConsumedProduct>((item) => ConsumedProduct.list(item))
              .toList();
          return products;
        }
        throw 'result is false';
      } else {
        throw 'no connection';
      }
    } catch (err) {
      print(err);
      return products;
    }
  }

  Future<List<ConsumedProduct>> yesterdayConsume() async {
    final String apiUrl =
        "https://mondelez-api.herokuapp.com/consume/yesterday";
    List<ConsumedProduct> products = [];
    var conn = await checkConnection();
    try {
      if (conn == null) {
        final response = await http.get(apiUrl, headers: <String, String>{
          'Authorization': 'Bearer ${blocControl.token}',
          'Content-Type': 'application/json; charset=UTF-8'
        });
        var resBody = jsonDecode(response.body);
        if (resBody['success'] == true && resBody['data'] != null) {
          products = resBody['data']['products']
              .map<ConsumedProduct>((item) => ConsumedProduct.list(item))
              .toList();
        }
        throw 'result is false';
      } else {
        throw 'no connection';
      }
    } catch (err) {
      print(err);
      return products;
    }
  }

  Future<List<ConsumedProduct>> lastweekConsume() async {
    final String apiUrl = "https://mondelez-api.herokuapp.com/consume/week";
    var conn = await checkConnection();
    List<ConsumedProduct> products = [];
    try {
      if (conn == null) {
        final response = await http.get(apiUrl, headers: <String, String>{
          'Authorization': 'Bearer ${blocControl.token}',
          'Content-Type': 'application/json; charset=UTF-8'
        });
        var resBody = jsonDecode(response.body);
        if (resBody['success'] == true && resBody['data'] != null) {
          resBody['data'].forEach((day) {
            day['products'].forEach((product) {
              ConsumedProduct p = ConsumedProduct.list(product);
              int index =
                  products.indexWhere((product) => product.name == p.name);
              if (index == -1) {
                products.add(p);
              } else {
                products[index].quantity += p.quantity;
              }
            });
          });
        }
        throw 'result is false';
      } else {
        throw 'no connection';
      }
    } catch (err) {
      print(err);
      return products;
    }
  }

  Future<String> dailyCalories(String day) async {
    final String apiUrl = "https://mondelez-api.herokuapp.com/consume/$day";
    var conn = await checkConnection();
    try {
      if (conn == null) {
        final response = await http.get(apiUrl, headers: <String, String>{
          'Authorization': 'Bearer ${blocControl.token}',
          'Content-Type': 'application/json; charset=UTF-8'
        });
        int weekCalories = 0;
        var resBody = jsonDecode(response.body);
        if (resBody['success'] == true && resBody['data'] != null) {
          if (day == 'week') {
            resBody['data'].forEach((day) {
              weekCalories += day["daily_calories"];
            });
          } else {
            weekCalories = (resBody['data']['daily_calories']);
          }
        }
        return weekCalories.toString();
      } else {
        throw 'no connection';
      }
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<List<Product>> searchApi(String item) async {
    final String apiUrl =
        "https://mondelez-api.herokuapp.com/products/search/$item?page=1";
    List<Product> products = [];
    var conn = await checkConnection();
    try {
      if (conn == null) {
        if (item.isNotEmpty) {
          final response = await http.get(apiUrl, headers: <String, String>{
            'Authorization': 'Bearer ${blocControl.token}',
            'Content-Type': 'application/json; charset=UTF-8'
          });
          var resBody = jsonDecode(response.body);
          if (resBody['success'] == true) {
            products = resBody['data']
                .map<Product>((item) => Product.list(item))
                .toList();
          }
        }
        return products;
      } else {
        throw 'no connection';
      }
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<dynamic> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return 'sorry, but you need to be connected to internet';
    }
    return null;
  }
}
