import 'package:flutter/material.dart';
import 'package:graduation_project/classes/blocControl.dart';
import '../classes/validateMixin.dart';

class SignUpNew extends StatefulWidget {
  createState() {
    return SignUpNewState();
  }
}

class SignUpNewState extends State<SignUpNew> with VaildateMixin {
  final formKey = GlobalKey<FormState>();
  var screenSize;

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
        child: Stack(
          children: [
            titlePanel(screenSize, "Let's Sign up,", blocControl.name),
            formTitlePanel(screenSize,
                "Type the email address you want to use to login to your account with us"),
            Positioned(
              top: screenSize.height * 0.265,
              child: Container(
                width: screenSize.width,
                height: screenSize.height * 0.11,
                padding: EdgeInsets.only(
                    left: screenSize.width * 0.065,
                    right: screenSize.width * 0.065),
                //color: Colors.blue,
                child: Form(
                  key: formKey,
                  child: emailField(),
                ),
              ),
            ),
            Positioned(
              bottom: keyboard == 0
                  ? screenSize.height * 0.08
                  : screenSize.height * 0.03,
              child: Container(
                width: screenSize.width,
                height: screenSize.height * 0.075,
                padding: EdgeInsets.only(
                    left: screenSize.width * 0.065,
                    right: screenSize.width * 0.065),
                //color: Colors.blue,
                child: nextButtonPanel(screenSize, formKey, context, 'email'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      cursorColor: colorChange('#4F2171'),
      autofocus: true,
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
      validator: validateEmail,
      onSaved: (value) {
        blocControl.setEmail(value);
      },
    );
  }
}
