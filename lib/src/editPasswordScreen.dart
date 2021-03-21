import 'package:flutter/material.dart';
import 'package:graduation_project/classes/blocControl.dart';
import 'package:graduation_project/classes/validateMixin.dart';

class EditPasswordScreen extends StatefulWidget {
  createState() {
    return EditPasswordState();
  }
}

class EditPasswordState extends State<EditPasswordScreen> with VaildateMixin {
  var screenSize;
  final formKey = GlobalKey<FormState>();
  TextEditingController oldControl = TextEditingController();
  TextEditingController passControl = TextEditingController();
  TextEditingController confirmControl = TextEditingController();
  bool visible = false;
  bool loading = false;
  String apiMessage = '';
  final focus = FocusNode();
  final focus2 = FocusNode();

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
      body: SingleChildScrollView(
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
                      "Change Password",
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
                      blocControl.signedIn ? blocControl.name : 'Visitor',
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
                'Set the new password you want to use for your account with us, enter it twice.',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: colorChange('#878787'),
                ),
              ),
            ),
            Container(
              width: screenSize.width,
              height: screenSize.height * 0.38,
              margin: EdgeInsets.only(top: screenSize.height * 0.022),
              padding: EdgeInsets.only(
                  left: screenSize.width * 0.065,
                  right: screenSize.width * 0.065),
              //color: Colors.blue,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    blocControl.signedIn
                        ? oldpasswordField('old password')
                        : Text(''),
                    Padding(
                      padding: EdgeInsets.only(
                          top: blocControl.password != null ? 40 : 10),
                      child: passwordField('new password'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: confirmPasswordField('new password again'),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: screenSize.width,
              height: screenSize.height * 0.075,
              margin: EdgeInsets.only(
                  top: keyboard == 0
                      ? screenSize.height * 0.12
                      : screenSize.height * 0.02,
                  bottom: keyboard == 0
                      ? screenSize.height * 0.0
                      : screenSize.height * 0.03),
              padding: EdgeInsets.only(
                  left: screenSize.width * 0.065,
                  right: screenSize.width * 0.065),
              //color: Colors.blue,
              child: nextButton('Next'),
            ),
          ],
        ),
      ),
    );
  }

  Widget oldpasswordField(String value) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      controller: oldControl,
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
      validator: validateOldPass,
    );
  }

  Widget passwordField(String value) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      controller: passControl,
      cursorColor: colorChange('#4F2171'),
      autofocus: true,
      focusNode: focus,
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
        FocusScope.of(context).requestFocus(focus2);
      },
      validator: validatePass,
    );
  }

  Widget confirmPasswordField(String value) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      cursorColor: colorChange('#4F2171'),
      textInputAction: TextInputAction.done,
      controller: confirmControl,
      obscureText: visible ? false : true,
      focusNode: focus2,
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
      onSaved: (String value) async {
        blocControl.setPassword(value);
      },
    );
  }

  String confirmPassword(String value) {
    if (confirmPass(value) != null) {
      setState(() {
        loading = false;
      });
      return confirmPass(value);
    } else
      return null;
  }

  Widget nextButton(String text) {
    return RaisedButton(
      onPressed: () async {
        setState(() {
          loading = true;
        });
        loginProcess();
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

  void loginProcess() async {
    String x = await resetPassword(
        oldControl.text, passControl.text, confirmControl.text);
    print(x);
    setState(() {
      apiMessage = x;
    });
    if (formKey.currentState.validate()) {
      Navigator.of(context).pop();
    }
  }

  String validateOldPass(String value) {
    if (validatePass(value) != null) {
      setState(() {
        loading = false;
      });
      return validatePass(value);
    }
    if (apiMessage.contains('correct')) {
      setState(() {
        loading = false;
      });
      return 'the password is wrong,enter it again';
    } else
      return null;
  }
}
