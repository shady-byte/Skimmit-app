import 'package:flutter/material.dart';
import 'package:graduation_project/classes/blocControl.dart';
import 'package:graduation_project/classes/validateMixin.dart';
import 'package:graduation_project/src/signupnew.dart';
import 'package:graduation_project/src/signupnew6.dart';

class SignUpNew2 extends StatefulWidget {
  createState() {
    return SignUpNew2State();
  }
}

class SignUpNew2State extends State<SignUpNew2> with VaildateMixin {
  final formKey = GlobalKey<FormState>();
  final focus = FocusNode();
  var screenSize;
  bool visible = false;
  bool loading = false;
  bool stored = false;

  Widget build(context) {
    screenSize = MediaQuery.of(context).size;
    var keyboard = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            //color: Colors.red,
            width: screenSize.width,
            padding: EdgeInsets.only(
                left: screenSize.width * 0.05,
                right: screenSize.width * 0.057,
                bottom: 5),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(
                'assets/images/logo.png',
                width: 100,
                height: 35,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                //color: Colors.blue,
                width: screenSize.width,
                height: screenSize.height * 0.15,
                padding: EdgeInsets.only(
                  left: screenSize.width * 0.065,
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 0,
                      child: Text(
                        "Let's Sign up,",
                        style: TextStyle(
                          fontSize: 36,
                          fontFamily: 'Bree Serif',
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Positioned(
                      top: screenSize.height * 0.071,
                      child: Text(
                        blocControl.name,
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
              Container(
                height: screenSize.height * 0.06,
                width: screenSize.width,
                margin: EdgeInsets.only(top: screenSize.height * 0.01),
                padding: EdgeInsets.only(
                    left: screenSize.width * 0.065,
                    right: screenSize.width * 0.2),
                //color: Colors.red,
                child: Text(
                  'Set the password you want to use for your account, enter it twice.',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: colorChange('#878787'),
                  ),
                ),
              ),
              Container(
                width: screenSize.width,
                height: screenSize.height * 0.22,
                margin: EdgeInsets.only(top: screenSize.height * 0.022),
                padding: EdgeInsets.only(
                    left: screenSize.width * 0.065,
                    right: screenSize.width * 0.065),
                //color: Colors.blue,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      passwordField('password'),
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: confirmPasswordField('password again'),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: screenSize.width,
                height: screenSize.height * 0.05,
                margin: EdgeInsets.only(
                  top: keyboard == 0
                      ? screenSize.height * 0.23
                      : screenSize.height * 0.04,
                ),
                padding: EdgeInsets.only(
                    left: screenSize.width * 0.065,
                    right: screenSize.width * 0.065),
                //color: Colors.blue,
                child: Center(
                  child: Text(
                    stored ? 'Sorry, Email already exists' : '',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              Container(
                width: screenSize.width,
                height: screenSize.height * 0.075,
                margin: EdgeInsets.only(
                  bottom: keyboard == 0
                      ? screenSize.height * 0.0
                      : screenSize.height * 0.03,
                  top: screenSize.height * 0.03,
                ),
                padding: EdgeInsets.only(
                    left: screenSize.width * 0.065,
                    right: screenSize.width * 0.065),
                //color: Colors.blue,
                child: nextButtonPanel2(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget passwordField(String value) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      cursorColor: colorChange('#4F2171'),
      autofocus: true,
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
        FocusScope.of(context).requestFocus(focus);
      },
      validator: validatePass2,
    );
  }

  Widget confirmPasswordField(String value) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      cursorColor: colorChange('#4F2171'),
      obscureText: visible ? false : true,
      focusNode: focus,
      autofocus: true,
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
      validator: confirmPassword,
      onSaved: (String value) {
        blocControl.setPassword(value);
      },
    );
  }

  String confirmPassword(String value) {
    if (confirmPass(value) != null) {
      setState(() {
        loading = false;
      });
    }
    return confirmPass(value);
  }

  String validatePass2(String value) {
    if (validatePass(value) != null) {
      setState(() {
        loading = false;
      });
    }
    return validatePass(value);
  }

  Widget nextButtonPanel2() {
    return RaisedButton(
      onPressed: () async {
        setState(() {
          loading = true;
        });
        if (formKey.currentState.validate()) {
          await formKey.currentState.save();
          bool x = await sendPersonalData();
          if (x == true) {
            setState(() {
              loading = false;
            });
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignUpNew6()),
            );
          } else {
            setState(() {
              loading = false;
              stored = true;
            });
            await Future.delayed(Duration(milliseconds: 1600), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignUpNew()),
              );
            });
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
        child: loading
            ? CircularProgressIndicator()
            : Text(
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
}
