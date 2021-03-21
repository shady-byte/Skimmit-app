import 'package:flutter/material.dart';
import 'package:graduation_project/classes/blocControl.dart';
import 'package:graduation_project/classes/validateMixin.dart';

class EditNameScreen extends StatefulWidget {
  createState() {
    return EditNameState();
  }
}

class EditNameState extends State<EditNameScreen> with VaildateMixin {
  var screenSize;
  final formKey = GlobalKey<FormState>();

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
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        //color: Colors.red,
        child: Stack(
          children: [
            titlePanel(screenSize, "Change Name,",
                blocControl.signedIn ? blocControl.name : 'Visitor'),
            formTitlePanel(screenSize,
                "Type the Name you want to use in your account with us"),
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
                  child: nameField("What's your new name?"),
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
                child: nextButtonPanel(screenSize, formKey, context, 'name'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget nameField(String hint) {
    return TextFormField(
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      cursorColor: colorChange('#4F2171'),
      autofocus: true,
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
      onSaved: (value) async {
        await updatePersonalData('name', value);
      },
    );
  }
}
