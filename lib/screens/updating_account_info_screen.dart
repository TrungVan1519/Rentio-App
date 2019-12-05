import 'package:flutter/material.dart';
import 'package:rentio/components/reusable_alert.dart';
import 'package:rentio/components/reusable_gradient_button_card.dart';
import 'package:rentio/utilities/constants.dart';
import 'package:rentio/services/regex_model.dart';

class UpdatingAccountInfoScreen extends StatefulWidget {
  @override
  _UpdatingAccountInfoScreenState createState() =>
      _UpdatingAccountInfoScreenState();
}

class _UpdatingAccountInfoScreenState extends State<UpdatingAccountInfoScreen> {
  bool _userNameValid = true;
  bool _passwordValid = true;

  String _userNameError = 'Error';
  String _passwordError = 'Error';

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
                      controller: _userNameController,
                      decoration: InputDecoration(
                        labelText: 'Username (6-30)',
                        labelStyle: TextStyle(
                          color: Colors.black,
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
                          color: Colors.black,
                          fontSize: kFontLabelSize,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                        errorText: _passwordValid ? null : _passwordError,
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
                    ),
                  ),
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

  onSavePressed() {
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

      if (_userNameValid && _passwordValid) {
        ReusableAlert(
          context: context,
          title: 'Conpleted',
          desc: 'Your account info was updated completed',
        ).getAlert();
      }
    });
  }
}
