import 'package:flutter/material.dart';
import 'package:graduation_project/classes/blocControl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../classes/validateMixin.dart';

class UserInfoScreen extends StatefulWidget {
  createState() {
    return UserInfoState();
  }
}

class UserInfoState extends State<UserInfoScreen> with VaildateMixin {
  var screenSize;
  String day = "Today's Calories";
  String choosen = "Today";

  Widget build(context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
        future: dailyCalories(choosen),
        builder: (context, AsyncSnapshot snapshot) {
          return Column(
            children: [
              SizedBox(
                width: screenSize.width,
                height: screenSize.height * 0.08,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: screenSize.width * 0.05,
                    right: screenSize.width * 0.05,
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        dateCalories('Today'),
                        Spacer(),
                        dateCalories('Yesterday'),
                        Spacer(),
                        dateCalories('Last Week'),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: screenSize.width * 0.05,
                      right: screenSize.width * 0.05,
                      top: screenSize.height * 0.025),
                  child: Text(
                    day,
                    style: TextStyle(
                      color: colorChange('#C3C2CB'),
                      fontSize: 18,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: screenSize.width * 0.05,
                    right: screenSize.width * 0.05,
                  ),
                  child: Row(
                    children: [
                      Text(
                        snapshot.data == null
                            ? ''
                            : snapshot.data.length > 3
                                ? snapshot.data[0] +
                                    ',' +
                                    snapshot.data.substring(1)
                                : snapshot.data,
                        style: TextStyle(
                          fontSize: 70,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: screenSize.height * 0.035),
                        child: Image.asset(
                          'assets/images/flame.png',
                          width: screenSize.width * 0.06,
                          height: screenSize.width * 0.06,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    height: screenSize.height * 0.4,
                    width: screenSize.width * 0.56,
                    margin: EdgeInsets.only(
                        top: screenSize.height * 0.025, left: 5.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: colorChange('#5243AC'),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: screenSize.height * 0.022),
                            child: Text(
                              'Junk Calories',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: CircularPercentIndicator(
                            radius: 200.0,
                            circularStrokeCap: CircularStrokeCap.round,
                            lineWidth: 13,
                            percent: calculatePercent(snapshot.data, choosen),
                            progressColor: Colors.white,
                            backgroundColor: colorChange('#7569BD'),
                            animation: true,
                            animationDuration: 700,
                            center: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(
                                  'assets/images/${blocControl.gender}.png'),
                              radius: 80,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom: screenSize.height * 0.022,
                                left: screenSize.width * 0.04,
                                right: screenSize.width * 0.04),
                            child: Text(
                              calculatePercent(snapshot.data, choosen) < 1
                                  ? 'You are still within the recommended intake'
                                  : 'You have exceeded the recommended intake',
                              style: TextStyle(
                                color: colorChange('#F8F8F8'),
                                fontSize: 14,
                                fontFamily: 'Poppins',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: screenSize.height * 0.4,
                    width: screenSize.width * 0.4,
                    margin: EdgeInsets.only(
                        top: screenSize.height * 0.025, left: 5, right: 5.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      //color: Colors.green,
                      border:
                          Border.all(color: colorChange('#E7E8EC'), width: 3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text(
                            'Total Calories',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          blocControl.bmr.toInt().toString().length > 3
                              ? blocControl.bmr.toInt().toString()[0] +
                                  ',' +
                                  blocControl.bmr
                                      .toInt()
                                      .toString()
                                      .substring(1)
                              : blocControl.bmr.toInt().toString(),
                          style: TextStyle(
                            color: colorChange('#5243AC'),
                            fontSize: 20,
                            //fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30, bottom: 5),
                          child: Text(
                            'Healthy Calories',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          (blocControl.bmr * (2 / 3))
                                      .toInt()
                                      .toString()
                                      .length >
                                  3
                              ? (blocControl.bmr * (2 / 3))
                                      .toInt()
                                      .toString()[0] +
                                  ',' +
                                  (blocControl.bmr * (2 / 3))
                                      .toInt()
                                      .toString()
                                      .substring(1)
                              : (blocControl.bmr * (2 / 3)).toInt().toString(),
                          style: TextStyle(
                            color: colorChange('#5243AC'),
                            fontSize: 20,
                            //fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30, bottom: 5),
                          child: Text(
                            'Junk Calories',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          (blocControl.bmr * (1 / 3))
                                      .toInt()
                                      .toString()
                                      .length >
                                  3
                              ? (blocControl.bmr * (1 / 3))
                                      .toInt()
                                      .toString()[0] +
                                  ',' +
                                  (blocControl.bmr * (1 / 3))
                                      .toInt()
                                      .toString()
                                      .substring(1)
                              : (blocControl.bmr * (1 / 3)).toInt().toString(),
                          style: TextStyle(
                            color: colorChange('#5243AC'),
                            fontSize: 20,
                            //fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget dateCalories(String value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          day = value + "'s" + ' Calories';
          choosen = value.contains('Week') ? 'week' : value;
        });
      },
      child: Container(
        width: screenSize.width * 0.27,
        height: screenSize.height * 0.04,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: value == 'Today'
              ? Colors.blue[200]
              : value == 'Yesterday'
                  ? Colors.grey[300]
                  : Colors.white,
          border: choosen == value
              ? Border.all(color: Colors.blue, width: 2)
              : choosen == 'week' && value == 'Last Week'
                  ? Border.all(color: Colors.blue, width: 2)
                  : value == 'Last Week'
                      ? Border.all(color: Colors.grey[350], width: 1)
                      : null,
        ),
        child: Center(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight:
                  choosen == value ? FontWeight.w700 : FontWeight.normal,
              color: choosen == value
                  ? colorChange('#1550C5')
                  : colorChange('#7D8492'),
            ),
          ),
        ),
      ),
    );
  }
}

double calculatePercent(String value, choosen) {
  double x = 0;
  if (value != null) {
    x = (choosen == 'week')
        ? int.parse(value) /
            (blocControl.bmr != 0 ? (blocControl.bmr * (1 / 3) * 7) : 1)
        : int.parse(value) /
            (blocControl.bmr != 0 ? (blocControl.bmr * (1 / 3)) : 1);
  }
  x >= 1 ? x = 1.0 : x;
  return x;
}
