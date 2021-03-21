import 'package:flutter/material.dart';
import 'package:graduation_project/classes/transition.dart';
import 'package:graduation_project/classes/validateMixin.dart';
import 'package:graduation_project/src/newSearchScreen.dart';

class CategorySelect extends StatefulWidget {
  final String category;
  CategorySelect({Key key, @required this.category}) : super(key: key);

  createState() {
    return CategorySelectState(category);
  }
}

class CategorySelectState extends State<CategorySelect> with VaildateMixin {
  var screenSize;
  String category;

  CategorySelectState(this.category);

  Widget build(context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: screenSize.width,
              height: screenSize.height * 0.155,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                color: colorChange('#EBEBEB'),
              ),
              child: Column(
                children: [
                  Container(
                    //color: Colors.red,
                    width: screenSize.width,
                    height: screenSize.height * 0.07,
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
                        IconButton(
                          icon: Icon(Icons.search),
                          iconSize: 30,
                          onPressed: () {
                            Navigator.of(context).push(Transitions(
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeIn,
                              reverseCurve: Curves.easeOut,
                              widget: NewSearchScreen(),
                              transitionType: TransitionType.slideUp,
                            ));
                          },
                        ),
                        userInfo(context, '1500', 'no'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenSize.height * 0.02),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, top: 8, right: 5),
                            child: Icon(
                              Icons.arrow_back,
                              size: 32,
                            ),
                          ),
                          Text(
                            category,
                            style: TextStyle(
                              fontSize: 28,
                              fontFamily: 'Bree Serif',
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: getCategoryProducts(category.toLowerCase()),
              builder: (conetxt, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Padding(
                    padding: EdgeInsets.only(top: screenSize.height * 0.2),
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(colorChange('#502171')),
                    ),
                  );
                }

                return Container(
                  width: screenSize.width,
                  height: screenSize.height * 0.725,
                  //color: Colors.grey,
                  padding: EdgeInsets.only(bottom: 5),
                  child: ListView.builder(
                    itemCount: (snapshot.data.length / 2).ceil(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      if (snapshot.data.length.isOdd) {
                        return index < (snapshot.data.length / 2).ceil() - 1
                            ? itemCard(
                                screenSize,
                                [
                                  snapshot.data[index * 2],
                                  snapshot.data[index * 2 + 1]
                                ],
                                true)
                            : itemCard(
                                screenSize, [snapshot.data[index * 2]], true);
                      } else {
                        return itemCard(
                          screenSize,
                          [
                            snapshot.data[index * 2],
                            snapshot.data[index * 2 + 1]
                          ],
                          true,
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
