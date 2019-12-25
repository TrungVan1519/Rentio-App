import 'package:flutter/material.dart';
import 'package:rentio/components/reusable_alert.dart';
import 'package:rentio/components/reusable_gradient_button_card.dart';
import 'package:rentio/services/http_executioner.dart';
import 'package:rentio/utilities/constants.dart';
import 'package:rentio/services/regex_validation.dart';
import 'package:http/http.dart' as http;

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
//        color: Colors.white,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/sign_in.jpg'),
            fit: BoxFit.cover,
          ),
        ),
//        decoration: BoxDecoration(
//          gradient: LinearGradient(
//            begin: Alignment.topRight,
//            end: Alignment.bottomLeft,
//            colors: [
//              Color(kGradientColorElement1),
//              Color(kGradientColorElement2)
//            ],
//          ),
//        ),
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
//                      decoration: InputDecoration(
//                        labelText: 'Username (6-30)',
//                        labelStyle: TextStyle(
//                          color: Colors.white,
//                          fontSize: kFontLabelSize,
//                          fontWeight: FontWeight.bold,
//                          letterSpacing: 0.5,
//                        ),
//                        errorText: _userNameValid ? null : _userNameError,
//                      ),
                      decoration: InputDecoration(
                        hintText: 'Username (6-30)',
                        hintStyle: TextStyle(
                          fontSize: kFontLabelSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          letterSpacing: 0.5,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10.0),
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
//                      decoration: InputDecoration(
//                        labelText: 'Password (6-30)',
//                        labelStyle: TextStyle(
//                          color: Colors.white,
//                          fontSize: kFontLabelSize,
//                          fontWeight: FontWeight.bold,
//                          letterSpacing: 0.5,
//                        ),
//                        errorText: _passwordValid ? null : _passwordError,
//                      ),
                      decoration: InputDecoration(
                        hintText: 'Password (6-30)',
                        hintStyle: TextStyle(
                          fontSize: kFontLabelSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          letterSpacing: 0.5,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10.0),
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
//                      decoration: InputDecoration(
//                        labelText: 'Full name (5-30)',
//                        labelStyle: TextStyle(
//                          color: Colors.white,
//                          fontSize: kFontLabelSize,
//                          fontWeight: FontWeight.bold,
//                          letterSpacing: 0.5,
//                        ),
//                        errorText: _fullNameValid ? null : _fullNameError,
//                      ),
                      decoration: InputDecoration(
                        hintText: 'Full name (5-30)',
                        hintStyle: TextStyle(
                          fontSize: kFontLabelSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          letterSpacing: 0.5,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10.0),
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
//                      decoration: InputDecoration(
//                        labelText: 'Phone number (9-30)',
//                        labelStyle: TextStyle(
//                          color: Colors.white,
//                          fontSize: kFontLabelSize,
//                          fontWeight: FontWeight.bold,
//                          letterSpacing: 0.5,
//                        ),
//                        errorText: _phoneNumberValid ? null : _phoneNumberError,
//                      ),
                      decoration: InputDecoration(
                        hintText: 'Phone number (10)',
                        hintStyle: TextStyle(
                          fontSize: kFontLabelSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          letterSpacing: 0.5,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10.0),
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
//                      decoration: InputDecoration(
//                        labelText: 'Email (@gmail.com)',
//                        labelStyle: TextStyle(
//                          color: Colors.white,
//                          fontSize: kFontLabelSize,
//                          fontWeight: FontWeight.bold,
//                          letterSpacing: 0.5,
//                        ),
//                        errorText: _emailValid ? null : _emailError,
//                      ),
                      decoration: InputDecoration(
                        hintText: 'Email (@gmail.com)',
                        hintStyle: TextStyle(
                          fontSize: kFontLabelSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          letterSpacing: 0.5,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10.0),
                        errorText: _emailValid ? null : _emailError,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
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
                        onPressed: onSignUpPressed,
                        child: Text(
                          'Sign up',
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
                      color: Colors.white,
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

  void onSignUpPressed() async {
    setState(() async {
      RegexModel regexModel = new RegexModel();

      // check username
      if (_userNameController.text.length >= 6 &&
          regexModel.isAllNormalCharaters(_userNameController.text)) {
        setState(() {
          _userNameValid = true;
        });
      } else {
        setState(() {
          _userNameValid = false;
        });
      }

      // check password
      if (_passwordController.text.length >= 6 &&
          regexModel.isAllNormalCharaters(_passwordController.text)) {
        setState(() {
          _passwordValid = true;
        });
      } else {
        setState(() {
          _passwordValid = false;
        });
      }

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
        setState(() {
          _phoneNumberValid = true;
        });
      } else {
        setState(() {
          _phoneNumberValid = false;
        });
      }

      // check email
      if (regexModel.isValidEmail(_emailController.text)) {
        setState(() {
          _emailValid = true;
        });
      } else {
        setState(() {
          _emailValid = false;
        });
      }

      if (_userNameValid &&
          _passwordValid &&
          _fullNameValid &&
          _phoneNumberValid &&
          _emailValid) {
        http.Response responsePost = await HttpExecutioner.post(
          requestURL: 'http://192.168.2.107:8080/register',
          headers: {"content-type": "application/json"},
          body: {
            'first_name': _fullNameController.text.split(' ')[0].trim() +
                ' ' +
                _fullNameController.text.split(' ')[1].trim(),
            'last_name': _fullNameController.text.split(' ')[2].trim(),
            'phone': _phoneNumberController.text,
            'email': _emailController.text,
            "username": _userNameController.text,
            "password": _passwordController.text
          },
        );
        if (responsePost.statusCode == 201) {
          ReusableAlert(
            context: context,
            title: 'Conpleted',
            desc: 'Your account was created completed',
          ).getAlert();
        } else {
          ReusableAlert(
            context: context,
            title: 'Uncompleted',
            desc: 'Your account was created fail',
          ).getAlert();
        }
      }
    });
  }
}
