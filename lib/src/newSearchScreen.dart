import 'package:flutter/material.dart';
import 'package:graduation_project/classes/blocControl.dart';
import 'package:graduation_project/src/newItemScreen.dart';
import '../classes/validateMixin.dart';
import 'dart:math' as math;

class NewSearchScreen extends StatefulWidget {
  createState() {
    return NewSearchState();
  }
}

class NewSearchState extends State<NewSearchScreen> with VaildateMixin {
  List<dynamic> searchResult = [];
  var screenSize;
  FocusNode focusNode;
  String searchValue = '';

  Widget build(context) {
    screenSize = MediaQuery.of(context).size;
    var keyboard = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: screenSize.width,
            height: screenSize.height * 0.07,
            margin: EdgeInsets.only(top: screenSize.height * 0.045),
            child: search(),
            color: Colors.grey[300],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding:
                  EdgeInsets.only(top: screenSize.height * 0.019, left: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    ),
                    Text(
                      'Search Results',
                      style: TextStyle(
                        fontSize: 23,
                        fontFamily: 'Bree Serif',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: keyboard == 0
                ? screenSize.height * 0.81
                : screenSize.height * 0.38,
            width: screenSize.width,
            padding: EdgeInsets.only(
              left: screenSize.width * 0.03,
              right: screenSize.width * 0.03,
            ),
            //color: Colors.red,
            child: FutureBuilder(
              future: searchApi(searchValue),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(colorChange('#502171')),
                    ),
                  );
                }
                return Column(
                  children: [
                    snapshot.data.isNotEmpty
                        ? SizedBox(
                            height: keyboard == 0
                                ? screenSize.height * 0.78
                                : screenSize.height * 0.326,
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return item(
                                  snapshot.data[index],
                                );
                              },
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(top: 60),
                            child: Text(
                              'No Results are found',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                              ),
                            ),
                          ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: keyboard == 0
                            ? EdgeInsets.only(top: 0)
                            : EdgeInsets.only(top: 15, left: 10),
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          child: (keyboard != 0 && snapshot.data.length > 3)
                              ? Text(
                                  'More Results',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                  ),
                                )
                              : Text(''),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget search() {
    return TextField(
      focusNode: focusNode,
      onChanged: (value) {
        print(value);
        setState(() {
          searchValue = value;
          print(searchValue);
        });
      },
      cursorColor: colorChange('#4F2171'),
      autofocus: true,
      style: TextStyle(
        fontSize: 16.0,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
        fillColor: Colors.grey[300],
        border: InputBorder.none,
        filled: true,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 20, right: 10),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: Icon(Icons.search, size: 27, color: Colors.black),
          ),
        ),
        hintText: 'What are you looking for ?',
        hintStyle: TextStyle(
          fontSize: 16.0,
        ),
      ),
    );
  }

  searchFunction(String value) {
    if (value.isNotEmpty) {
      searchApi(value).then((products) {
        setState(() {
          searchResult = products;
        });
      });
    } else {
      setState(() {
        searchResult = [];
      });
    }
  }

  Widget item(var value) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: colorChange('#E8E8E8'), width: 2),
      ),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => NewItemScreen(
              product: value,
            ),
          ));
        },
        title: Text(
          value.name,
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: 'Bree Serif',
            color: Colors.black,
          ),
        ),
        subtitle: Row(
          children: [
            Image.asset(
              'assets/images/flame.png',
              //color: colorChange('#545651'),
              width: 15,
              height: 15,
            ),
            Padding(padding: EdgeInsets.only(right: 5)),
            Text(
              value.meta['calories'].toString(),
              style: TextStyle(
                color: colorChange('#545651'),
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
        leading: Image.network(
          url + value.imageurl,
          width: 50,
        ),
        trailing: CircleAvatar(
          radius: 19,
          backgroundColor: colorChange('#E8E8E8'),
          child: CircleAvatar(
            radius: 17,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            child: Icon(
              Icons.arrow_forward,
            ),
          ),
        ),
      ),
    );
  }
}
