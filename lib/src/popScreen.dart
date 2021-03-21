import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../classes/blocControl.dart';
import 'package:graduation_project/src/HomeScreen.dart';
import 'package:graduation_project/src/signupnew.dart';
import '../classes/validateMixin.dart';

class Page1 extends StatefulWidget {
  var screenSize;
  var currentView;
  Page1({Key key, @required this.screenSize, @required this.currentView});
  createState() {
    return Page1State(screenSize, currentView);
  }
}

class Page1State extends State<Page1> with VaildateMixin {
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  TextEditingController emailControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  final focus = FocusNode();
  int currentview;
  String apiMessage;
  bool visible = false;
  bool loading = false;
  var screenSize;

  Page1State(this.screenSize, this.currentview);

  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height * 0.55,
      margin: EdgeInsets.only(
        left: 7,
        right: 7,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(21), topRight: Radius.circular(21)),
        color: Colors.grey[350],
      ),
      child: Container(
        padding: EdgeInsets.only(top: 20, left: 10, right: 10),
        margin: EdgeInsets.only(
          left: 3,
          right: 3,
          top: 3,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(21), topRight: Radius.circular(21)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              height: screenSize.height * 0.092,
              //color: Colors.green,
              child: rowOne(),
            ),
            currentview == 0 ? loginPage() : signupPage(),
          ],
        ),
      ),
    );
  }

  Widget loginPage() {
    return Form(
      key: formKey,
      child: Container(
        height: screenSize.height * 0.41,
        //color: Colors.blue,
        padding: EdgeInsets.only(top: 15),
        child: Column(
          children: [
            emailField(),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: passwordField('Password'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 25),
              child: nextButton('Login Now'),
            ),
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'Forgot your password?',
                  style: TextStyle(
                    color: colorChange('#172731'),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              onTap: () {
                print('your password is checked');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget signupPage() {
    return Form(
      key: formKey2,
      child: Container(
        height: screenSize.height * 0.41,
        //color: Colors.blue,
        padding: EdgeInsets.only(top: 15),
        child: Column(
          children: [
            formTitle(
                'Monitor all your fast-food calories intake, type your name to start registration.'),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: nameField("What's your name?"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 25),
              child: nextButton('Sign Up Now'),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowOne() {
    return Row(
      children: [
        FlatButton(
          //color: Colors.red,
          onPressed: () {
            setState(() {
              currentview = 0;
            });
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              'Sign In',
              style: TextStyle(
                color: currentview == 0
                    ? colorChange('#502171')
                    : colorChange('#636363'),
                fontSize: 24,
              ),
            ),
          ),

          shape: Border(
            bottom: BorderSide(
                width: 2,
                color: currentview == 0
                    ? colorChange('#CE1127')
                    : Colors.grey[350]),
          ),
        ),
        FlatButton(
          //color: Colors.red,
          onPressed: () {
            setState(() {
              currentview = 1;
            });
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              'Sign Up',
              style: TextStyle(
                color: currentview == 1
                    ? colorChange('#502171')
                    : colorChange('#636363'),
                fontSize: 24,
              ),
            ),
          ),
          shape: Border(
            bottom: BorderSide(
                width: 2,
                color: currentview == 1
                    ? colorChange('#CE1127')
                    : Colors.grey[350]),
          ),
        ),
        SizedBox(
          width: screenSize.width * 0.326,
          child: FlatButton.icon(
            //color: Colors.red,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Padding(
              padding: EdgeInsets.only(bottom: 27, left: 36),
              child: Icon(
                Icons.close,
                color: Colors.black,
                size: 18,
              ),
            ),
            label: Padding(
              padding: EdgeInsets.only(bottom: 28),
              child: Text(
                'Close',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            shape: Border(
              bottom: BorderSide(width: 2, color: Colors.grey[350]),
            ),
          ),
        ),
      ],
    );
  }

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      cursorColor: colorChange('#4F2171'),
      textInputAction: TextInputAction.next,
      controller: emailControl,
      decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.email,
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(90.0)),
            borderSide: BorderSide.none,
          ),
          hintStyle:
              TextStyle(color: colorChange('#878787'), fontFamily: 'Poppins'),
          filled: true,
          fillColor: colorChange('F4F4F4'),
          hintText: 'Email address'),
      onFieldSubmitted: (v) {
        FocusScope.of(context).requestFocus(focus);
      },
      validator: validateEmail2,
    );
  }

  Widget passwordField(String value) {
    return TextFormField(
      focusNode: focus,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      controller: passwordControl,
      cursorColor: colorChange('#4F2171'),
      obscureText: visible ? false : true,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 17, right: 20),
          child: Icon(
            Icons.vpn_key,
            color: Colors.black,
          ),
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: 10),
          child: IconButton(
            icon: visible ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
            color: Colors.grey,
            onPressed: () {
              visible
                  ? setState(() {
                      visible = false;
                    })
                  : setState(() {
                      visible = true;
                    });
            },
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(90.0)),
          borderSide: BorderSide.none,
        ),
        hintStyle:
            TextStyle(color: colorChange('#878787'), fontFamily: 'Poppins'),
        filled: true,
        fillColor: colorChange('F4F4F4'),
        hintText: value,
      ),
      onFieldSubmitted: (v) {
        FocusScope.of(context).unfocus();
      },
      validator: validatePass2,
    );
  }

  Widget nameField(String hint) {
    return TextFormField(
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      cursorColor: colorChange('#4F2171'),
      decoration: InputDecoration(
        prefix: Padding(
          padding: EdgeInsets.only(left: 10),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(90.0)),
          borderSide: BorderSide.none,
        ),
        hintStyle:
            TextStyle(color: colorChange('#878787'), fontFamily: 'Poppins'),
        filled: true,
        fillColor: colorChange('F4F4F4'),
        hintText: hint,
      ),
      validator: validateName,
      onSaved: (value) {
        List<String> name = value.split(' ');
        blocControl.setName(name[0]);
      },
    );
  }

  Widget nextButton(String text) {
    return RaisedButton(
      onPressed: () async {
        if (text == 'Login Now') {
          setState(() {
            loading = true;
          });
        }

        if (text == 'Login Now') {
          loginProcess();
        } else {
          checkConnection().then((msg) {
            if (msg == null) {
              if (formKey2.currentState.validate()) {
                formKey2.currentState.save();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpNew(),
                    ));
              }
            } else {
              Fluttertoast.showToast(
                msg: "you need to be connected to internet",
                backgroundColor: Colors.grey[700],
                textColor: Colors.white,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
              );
              setState(() {
                loading = false;
              });
            }
          });
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
        child: loading
            ? CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                  Colors.blue,
                ),
                strokeWidth: 2.5,
              )
            : Text(
                text,
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

  Widget formTitle(String title) {
    return Container(
      height: screenSize.height * 0.077,
      width: screenSize.width,
      padding: EdgeInsets.only(left: 10, right: 10),
      //color: Colors.red,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontFamily: 'Poppins',
          color: colorChange('#878787'),
        ),
      ),
    );
  }

  String validateEmail2(value) {
    if (validateEmail(value) != null) {
      setState(() {
        loading = false;
      });
      return validateEmail(value);
    }
    if (apiMessage == null)
      return null;
    else if (apiMessage.contains('user')) {
      setState(() {
        loading = false;
      });
      return 'The user does not exist';
    }
    return null;
  }

  String validatePass2(value) {
    if (validatePass(value) != null) {
      setState(() {
        loading = false;
      });
      return validatePass(value);
    }
    if (apiMessage == null)
      return null;
    else if (apiMessage.contains('password')) {
      setState(() {
        loading = false;
      });
      return 'The password is not correct';
    }
    return null;
  }

  void loginProcess() async {
    String x = await loginApi(emailControl.text, passwordControl.text);
    setState(() {
      apiMessage = x;
    });
    if (formKey.currentState.validate()) {
      await launchingApp();
      setState(() {
        loading = false;
      });
      Navigator.of(context).pop();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            currentState: 'home',
          ),
        ),
      );
    }
  }
}
