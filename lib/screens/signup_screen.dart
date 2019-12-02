import 'package:flutter/material.dart';
import 'package:rentio/utilities/constants.dart';
import 'package:rentio/validation/regex_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _userNameValid = true;
  bool _passwordValid = true;
  bool _fullNameValid = true;
  bool _phoneNumberValid = true;
  bool _emailValid = true;
  String _userNameError = 'Error';
  String _passwordError = 'Error';
  String _fullNameError = 'Error';
  String _phoneNumberError = 'Error';
  String _emailError = 'Error';
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        padding: EdgeInsets.all(20.0),
        // > padding toan bo Widgets con theo left right, top, bottom
        // > Cac Widgets con chi can padding top, bottom voi nhau ma khong can
        //    padding left, right
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(kGradientColorElement1),
              Color(kGradientColorElement2)
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Welcome to Retio',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: kFontTextSize,
                  fontWeight: FontWeight.bold,
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
                controller: _userNameController,
                decoration: InputDecoration(
                  labelText: 'Username (6-30)',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: kFontLabelSize,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                  errorText: _userNameValid ? null : _userNameError,
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
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password (6-30)',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: kFontLabelSize,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                  errorText: _passwordValid ? null : _passwordError,
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
                  labelText: 'Full name',
                  labelStyle: TextStyle(
                    color: Colors.white,
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
                maxLength: 30,
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone number',
                  labelStyle: TextStyle(
                    color: Colors.white,
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
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: kFontLabelSize,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                  errorText: _emailValid ? null : _emailError,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Container(
                width: 200.0,
                height: 50.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.white,
                  onPressed: onSignUpPressed,
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: kFontTextSize,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onSignUpPressed() {
    setState(() {
      RegexModel regexModel = new RegexModel();

      // check username
      if (_userNameController.text.length >= 6 &&
          regexModel.isAllNormalCharaters(_userNameController.text)) {
        _userNameValid = true;
      } else {
        _userNameValid = false;
      }

      // check password
      if (_passwordController.text.length >= 6 &&
          regexModel.isAllNormalCharaters(_passwordController.text)) {
        _passwordValid = true;
      } else {
        _passwordValid = false;
      }

      // check fullname
      if (_fullNameController.text.length >= 5) {
        _fullNameValid = true;
      } else {
        _fullNameValid = false;
      }

      // check phonenumber
      if (_phoneNumberController.text.length >= 9 &&
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
    });
  }
}
