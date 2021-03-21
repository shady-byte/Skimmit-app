import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_project/classes/blocControl.dart';
import 'package:graduation_project/classes/product.dart';
import 'package:graduation_project/src/userInfoScreen.dart';
import '../classes/validateMixin.dart';
import 'HomeScreen.dart';

class NewItemScreen extends StatefulWidget {
  final Product product;
  NewItemScreen({Key key, @required this.product}) : super(key: key);
  createState() {
    return ItemScreenState(product);
  }
}

class ItemScreenState extends State<NewItemScreen> with VaildateMixin {
  List<String> diseases = [
    'Diabetes',
    'High Blood Pressure',
    'Cholesterol',
    'Allergy',
    'Insomnia'
  ];
  List<String> ownDiseases = [];
  var screenSize;
  int quantity = 1;
  bool swipe = false;
  bool loading = false;
  Product product;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  ItemScreenState(this.product);

  initState() {
    product.diseases.forEach((item) => ownDiseases.add(item['name']));
    super.initState();
  }

  Widget build(context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Builder(builder: (context) {
        return Container(
          width: screenSize.width,
          height: screenSize.height * 0.196,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: screenSize.width * 0.87,
                height: screenSize.height * 0.075,
                //color: Colors.green,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        quantity > 1 ? '$quantity Pieces' : '$quantity Piece',
                        style: TextStyle(
                          fontSize: 21,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Spacer(),
                    buttons(),
                  ],
                ),
              ),
              Container(
                width: screenSize.width * 0.87,
                height: screenSize.height * 0.075,
                child: RaisedButton(
                  onPressed: !loading
                      ? () async {
                          setState(() {
                            loading = true;
                          });
                          consumeProduct(product.barcode, quantity)
                              .then((value) {
                            if (value == null) {
                              Fluttertoast.showToast(
                                msg: quantity == 1
                                    ? "$quantity ${product.name} is added"
                                    : "$quantity ${product.name} are added",
                                backgroundColor: Colors.grey[700],
                                textColor: Colors.white,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                              );
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(
                                    currentState: 'home',
                                  ),
                                ),
                              );
                            } else {
                              Fluttertoast.showToast(
                                msg: value.contains('unauthorized')
                                    ? 'you have to signin first'
                                    : 'something went wrong,try again later',
                                backgroundColor: Colors.grey[700],
                                textColor: Colors.white,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                              );
                              value.contains('unauthorized')
                                  ? Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => HomeScreen(
                                          currentState: 'settings',
                                        ),
                                      ),
                                    )
                                  : Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => HomeScreen(
                                          currentState: 'home',
                                        ),
                                      ),
                                    );
                            }
                            setState(() {
                              loading = false;
                            });
                          });
                        }
                      : () {},
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
                    child: loading
                        ? CircularProgressIndicator()
                        : Text(
                            'Add Now',
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
            ],
          ),
        );
      }),
      backgroundColor: Colors.yellow[100],
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: screenSize.height * 0.065, left: screenSize.width * 0.755),
            width: screenSize.width,
            height: screenSize.height * 0.1,
            //color: Colors.blue,
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
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Container(
            margin:
                EdgeInsets.fromLTRB(0.0, screenSize.height * 0.05, 0.0, 0.0),
            width: screenSize.width * 0.75,
            height: swipe ? screenSize.height * 0.25 : screenSize.height * 0.3,
            decoration: BoxDecoration(
              //color:Colors.red,
              image: DecorationImage(
                image: NetworkImage(
                  url + product.imageurl,
                ),
                fit: BoxFit.contain,
              ),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
          ),
          Container(
            width: screenSize.width,
            height: screenSize.height * 0.55,
            margin: swipe
                ? EdgeInsets.only(top: screenSize.height * 0.05)
                : EdgeInsets.only(top: 0),
            //color: Colors.green,
            child: NotificationListener<DraggableScrollableNotification>(
              onNotification: (notification) {
                if (notification.extent >= 0.94) {
                  setState(() {
                    swipe = true;
                  });
                } else {
                  setState(() {
                    swipe = false;
                  });
                }
                return true;
              },
              child: DraggableScrollableSheet(
                minChildSize: 0.91,
                initialChildSize: 0.91,
                maxChildSize: 1,
                expand: true,
                builder: (context, scrollController) {
                  return Container(
                    width: screenSize.width,
                    height: screenSize.height * 0.54,
                    padding: EdgeInsets.only(top: screenSize.height * 0.02),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              product.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 27.0,
                                fontFamily: 'Bree Serif',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/flame.png',
                                  width: 20,
                                  height: 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 3),
                                  child: Text(
                                    product.meta['calories'].toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      color: colorChange('#545651'),
                                    ),
                                  ),
                                ),

                                Padding(padding: EdgeInsets.only(left: 20)),
                                //'${product['type']}.png'
                                Image.asset(
                                  'assets/images/${product.category}.png',
                                  width: 20,
                                  height: 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 3),
                                  child: Text(
                                    product.category,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      color: colorChange('#545651'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenSize.width * 0.06,
                                top: screenSize.height * 0.047),
                            child: Text(
                              'Avoid if you have:',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Bree Serif',
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: screenSize.height * 0.02),
                            child: Container(
                              width: screenSize.width,
                              height: screenSize.height * 0.13,
                              //color: Colors.red,
                              padding: EdgeInsets.only(
                                  left: screenSize.width * 0.06,
                                  right: screenSize.width * 0.06),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: diseases.length,
                                itemBuilder: (context, int index) {
                                  String image = 'assets/images/' +
                                      diseases[index]
                                          .replaceAll(new RegExp('\\s+'), "") +
                                      '.png';
                                  return Container(
                                    width: screenSize.width * 0.2,
                                    margin: EdgeInsets.only(right: 10.0),
                                    padding: EdgeInsets.only(
                                      left: 4,
                                      right: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      border: Border.all(
                                          color: ownDiseases.contains(
                                                  diseases[index].toLowerCase())
                                              ? colorChange('#502171')
                                              : colorChange('#EBEBEB'),
                                          width: 2),
                                      color: ownDiseases.contains(
                                              diseases[index].toLowerCase())
                                          ? colorChange('#502171')
                                          : Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          image,
                                          width: 40,
                                          height: 40,
                                          color: ownDiseases.contains(
                                                  diseases[index].toLowerCase())
                                              ? Colors.white
                                              : colorChange('#502171'),
                                        ),
                                        Text(
                                          diseases[index],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            color: ownDiseases.contains(
                                                    diseases[index]
                                                        .toLowerCase())
                                                ? Colors.white
                                                : colorChange('#545651'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenSize.width * 0.06,
                                top: screenSize.height * 0.047),
                            child: Text(
                              'Nutritional Summary:',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Bree Serif',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenSize.width * 0.06,
                                right: screenSize.width * 0.06,
                                top: screenSize.width * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                mineralsDisplay(
                                  'Total Fats: ',
                                  'Calcium: ',
                                  'Total Sugars: ',
                                  product.meta['trans_fat'],
                                  product.meta['calcium'],
                                  product.meta['sugar'],
                                ),
                                Spacer(),
                                mineralsDisplay(
                                  'Iron: ',
                                  'Cholesterol: ',
                                  '',
                                  product.meta['iron'],
                                  product.meta['cholesterol'],
                                  '',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenSize.height * 0.19,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttons() {
    return Container(
      width: screenSize.width * 0.5,
      height: screenSize.height * 0.075,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              print('less items');
              if (quantity > 1) {
                setState(() {
                  quantity = quantity - 1;
                });
              }
            },
            child: Container(
              width: screenSize.width * 0.195,
              height: screenSize.height * 0.043,
              decoration: BoxDecoration(
                  color: colorChange('#FEFAEF'),
                  borderRadius: BorderRadius.circular(5.0)),
              child: Icon(Icons.remove, color: Colors.black, size: 30),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                quantity = quantity + 1;
              });
            },
            child: Container(
              width: screenSize.width * 0.195,
              height: screenSize.height * 0.043,
              decoration: BoxDecoration(
                  color: colorChange('#F1F4EB'),
                  borderRadius: BorderRadius.circular(5.0)),
              child: Icon(Icons.add, color: Colors.black, size: 30),
            ),
          ),
        ],
      ),
    );
  }

  Widget mineralsDisplay(String item1, item2, item3, v1, v2, v3) {
    return Container(
      width: screenSize.width * 0.4,
      height: screenSize.height * 0.1,
      //color:Colors.red,
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenSize.height * 0.01, left: 8),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  item1 + v1,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: screenSize.height * 0.01,
                  bottom: screenSize.height * 0.01,
                  left: 8),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  item2 + v2,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  item3 + v3,
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showSnackBar() {
    return SnackBar(
      content: Text(quantity == 1
          ? "$quantity ${product.name} is added"
          : "$quantity ${product.name} are added"),
      duration: Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.grey[800],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      action: SnackBarAction(
        label: 'view Calories',
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => UserInfoScreen()));
        },
      ),
    );
  }
}
