import 'package:flutter/material.dart';
import 'package:rentio/components/reusable_alert.dart';
import 'package:rentio/components/reusable_gradient_button_card.dart';
import 'package:rentio/global_data/global_user.dart';
import 'package:rentio/services/http_executioner.dart';
import 'package:rentio/utilities/constants.dart';
import 'package:rentio/services/regex_validation.dart';
import 'package:http/http.dart' as http;

class UpdatingUserInfoScreen extends StatefulWidget {
  @override
  _UpdatingUserInfoScreenState createState() => _UpdatingUserInfoScreenState();
}

class _UpdatingUserInfoScreenState extends State<UpdatingUserInfoScreen> {
  bool _fullNameValid = true;
  bool _phoneNumberValid = true;
  bool _emailValid = true;
  String _fullNameError = 'Error';
  String _phoneNumberError = 'Error';
  String _emailError = 'Error';
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              // > padding toan bo Widgets con theo left right, top, bottom
              // > Cac Widgets con chi can padding top, bottom voi nhau ma khong can
              //    padding left, right
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Container(
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                        image: DecorationImage(
                          image: AssetImage('images/default_app_avatar.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextField(
                      style: TextStyle(
                        fontSize: kFontTextSize,
                      ),
                      maxLength: 30,
                      controller: _fullNameController,
                      decoration: InputDecoration(
                        labelText: 'Full name (5-30)',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: kFontLabelSize,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                        errorText: _fullNameValid ? null : _fullNameError,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextField(
                      style: TextStyle(
                        fontSize: kFontTextSize,
                      ),
                      maxLength: 10,
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                        labelText: 'Phone number (10)',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: kFontLabelSize,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                        errorText: _phoneNumberValid ? null : _phoneNumberError,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextField(
                      style: TextStyle(
                        fontSize: kFontTextSize,
                      ),
                      maxLength: 30,
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email (@gmail.com)',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: kFontLabelSize,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                        errorText: _emailValid ? null : _emailError,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      width: 200.0,
                      height: 50.0,
                      child: RaisedGradientButton(
                        borderRadius: BorderRadius.circular(30.0),
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(kGradientColorElement1),
                            Color(kGradientColorElement2),
                          ],
                        ),
                        onPressed: onSavePressed,
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: kFontTextSize,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
//                child: RaisedButton(
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(10.0),
//                  ),
//                  color: Colors.white,
//                  onPressed: onSignUpPressed,
//                  child: Text(
//                    'Sign up',
//                    style: TextStyle(
//                      color: Colors.teal,
//                      fontSize: kFontTextSize,
//                      fontWeight: FontWeight.bold,
//                    ),
//                    textAlign: TextAlign.center,
//                  ),
//                ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Color(kGradientColorElement1),
                    ),
                    onPressed: onBackwardPressed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onBackwardPressed() {
    Navigator.pop(context);
  }

  void onSavePressed() async {
    setState(() async {
      RegexModel regexModel = new RegexModel();

      // check fullname
      if (_fullNameController.text.length >= 5 &&
          regexModel.isValidFullName(_fullNameController.text)) {
        setState(() {
          _fullNameValid = true;
        });
      } else {
        setState(() {
          _fullNameValid = false;
        });
      }

      // check phonenumber
      if (_phoneNumberController.text.length >= 10 &&
          regexModel.isAllNumber(_phoneNumberController.text)) {
        _phoneNumberValid = true;
      } else {
        _phoneNumberValid = false;
      }

      // check email
      if (regexModel.isValidEmail(_emailController.text)) {
        _emailValid = true;
      } else {
        _emailValid = false;
      }

      if (_fullNameValid && _phoneNumberValid && _emailValid) {
        ReusableAlert(
          context: context,
          title: 'Conpleted',
          desc: 'Your info was updated completed',
        ).getAlert();
      }

      http.Response responsePost = await HttpExecutioner.post(
        requestURL:
            'http://172.20.10.5:8080/edit_profile/${GlobalUser.globalUser.userName}',
        headers: {
          "content-type": "application/json",
          'authorization': 'JWT ${GlobalUser.globalUser.id}'
        },
        body: {
          'first_name': _fullNameController.text.split(' ')[0].trim() +
              ' ' +
              _fullNameController.text.split(' ')[1].trim(),
          'last_name': _fullNameController.text.split(' ')[2].trim(),
          'gender': null,
          'birthday': null,
          'phone': _phoneNumberController.text,
          'email': _emailController.text,
          'address': null,
          'job': null
        },
      );
      if (responsePost.statusCode == 200) {
        ReusableAlert(
          context: context,
          title: 'Conpleted',
          desc: 'Your account was updated completed',
        ).getAlert();
      } else {
        ReusableAlert(
          context: context,
          title: 'Uncompleted',
          desc: 'Your account was updated fail',
        ).getAlert();
      }
    });
  }
}
