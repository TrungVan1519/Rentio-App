import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rentio/components/reusable_alert.dart';
import 'package:rentio/components/reusable_gradient_button_card.dart';
import 'package:rentio/components/reusable_loading_card.dart';
import 'package:rentio/global_data/global_user.dart';
import 'package:rentio/services/http_executioner.dart';
import 'package:rentio/screens/user_screen.dart';
import 'package:rentio/utilities/constants.dart';
import 'package:http/http.dart' as http;

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _hidePassword = true;
  bool _userNameValid = false;
  bool _passwordValid = false;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          IndexedStack(
            index: isLoading ? 0 : 1,
            children: <Widget>[
              Container(
                child: Center(
                  child: CubeGridLoading(),
                ),
              ),
              Container(
                constraints: BoxConstraints.expand(),
                padding: EdgeInsets.all(20.0),
                // > padding toan bo Widgets con theo left right, top, bottom
                // > Cac Widgets con chi can padding top, bottom voi nhau ma khong can
                //    padding left, right
//                decoration: BoxDecoration(
//                  gradient: LinearGradient(
//                    begin: Alignment.topRight,
//                    end: Alignment.bottomLeft,
//                    colors: [
//                      Color(kGradientColorElement1),
//                      Color(kGradientColorElement2)
//                    ],
//                  ),
//                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/sign_in.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
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
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 50.0),
                        child: Text(
                          'Welcome to Retio',
                          style: TextStyle(
                            fontFamily: 'Pacifico',
                            fontSize: kFontTextSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextField(
                        style: TextStyle(
                          fontSize: kFontTextSmallSize,
                        ),
                        maxLength: 30,
                        controller: _userNameController,
                        decoration: InputDecoration(
                          hintText: 'Username',
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
                              Radius.circular(5),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 10.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: <Widget>[
                          TextField(
                            style: TextStyle(
                              fontSize: kFontTextSmallSize,
                            ),
                            obscureText: _hidePassword,
                            maxLength: 30,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              hintText: 'Password',
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
                                  Radius.circular(5),
                                ),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                            ),
                          ),
                          GestureDetector(
                            onTap: onTogglePassword,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                _hidePassword ? 'SHOW' : 'HIDE',
                                style: TextStyle(
                                  color: Color(kGradientColorElement1),
                                  fontSize: kFontTextSmallSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 50.0,
                      child: RaisedGradientButton(
                        borderRadius: BorderRadius.circular(30.0),
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(kGradientColorElement1),
                            Color(kGradientColorElement2),
                          ],
                        ),
                        onPressed: onSignInPressed,
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: kFontTextSize,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
//                  child: RawMaterialButton(
//                    shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(10.0),
//                    ),
//                    fillColor: Colors.white,
//                    onPressed: onSignInPressed,
//                    child: Text(
//                      'Sign in',
//                      style: TextStyle(
//                        color: Colors.teal,
//                        fontSize: kFontTextSize,
//                        fontWeight: FontWeight.bold,
//                      ),
//                      textAlign: TextAlign.center,
//                    ),
//                  ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: GestureDetector(
                          onTap: onForgotPasswordPressed,
                          child: Text(
                            'Forgot password.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: kFontLabelSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
//            Padding(
//              padding: const EdgeInsets.symmetric(vertical: 20.0),
//              child: Row(
////                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                // > Khong wrap Expand Widget thi phai su dung thuoc tinh nay
//                children: <Widget>[
//                  Expanded(
//                    child: Text(
//                      'Forgot password.',
//                      textAlign: TextAlign.center,
//                      style: TextStyle(
//                        fontSize: kFontLabelSize,
//                        fontWeight: FontWeight.bold,
//                        color: Colors.blue,
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            )
                  ],
                ),
              ),
            ],
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
    );
  }

  void onTogglePassword() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  void onSignInPressed() async {
    setState(() {
      isLoading = true;
    });

    // http://192.168.2.107:8080/auth
    http.Response responsePost = await HttpExecutioner.post(
      requestURL: 'http://192.168.2.107:8080/auth',
      headers: {"content-type": "application/json"},
      body: {
        "username": _userNameController.text,
        "password": _passwordController.text
      },
    );
//    for (var i in responsePost.headers.keys) {
//      print(i);
//    }

    if (responsePost.statusCode == 200) {
      final data = json.decode(responsePost.body);

      GlobalUser.globalUser.id = data['access_token'];
      GlobalUser.globalUser.userName = _userNameController.text;
      print('GlobalUser.globalUser.id' + GlobalUser.globalUser.id);
      print(
          'GlobalUser.globalUser.userName: ${GlobalUser.globalUser.userName}');

      _userNameValid = true;
      _passwordValid = true;

//    final data = await JsonGetter(jsonFileName: 'data/login.json').loadData();
//
//    if (data != null) {
//      if (_userNameController.text.compareTo(data['username']) == 0) {
//        _userNameValid = true;
//      } else {
//        _userNameValid = false;
//      }
//
//      if (_passwordController.text.compareTo(data['password']) == 0) {
//        _passwordValid = true;
//      } else {
//        _passwordValid = false;
//      }

      if (_userNameValid && _passwordValid) {
        // Dong data nay de truyen sang UserScreen
//        final userData =
//            await JsonGetter(jsonFileName: 'data/signup.json').loadData();

        // http://192.168.2.107:8080/user/<username>
        http.Response responseGet = await HttpExecutioner.get(
          requestURL:
              'http://192.168.2.107:8080/user/${GlobalUser.globalUser.userName}',
          headers: {
            "content-type": "application/json",
            'authorization': 'JWT ${GlobalUser.globalUser.id}'
          },
        );

        final userData = json.decode(responseGet.body);
        GlobalUser.globalUser.userID = userData['id'];
        String fullName = userData['first_name'] + ' ' + userData['last_name'];

        isLoading = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserScreen(
              fullName: fullName,
            ),
          ),
        );
      } else {
        ReusableAlert(
          context: context,
          title: 'Not exist',
          desc: 'Your account is not exist',
        ).getAlert();
      }
    } else {
      ReusableAlert(
        context: context,
        title: 'Internet problems',
        desc: 'Your internet has problem',
      ).getAlert();
    }

    setState(() {
      isLoading = false;
    });

//    http.Response responsePost = await HttpExecutioner.post(
//      requestURL: 'http://192.168.2.107:8080/auth',
//      headers: {"content-type": "application/json"},
//      body: {
//        "username": _userNameController.text,
//        "password": _passwordController.text
//      },
//    );
//    final data = json.decode(responsePost.body);
//
//    if (responsePost.statusCode == 200) {
//      GlobalUser.globalUser.id = data['access_token'];
//      GlobalUser.globalUser.userName = _userNameController.text;
//      print('GlobalUser.globalUser.id' + GlobalUser.globalUser.id);
//      print(
//          'GlobalUser.globalUser.userName: ${GlobalUser.globalUser.userName}');
//
//      http.Response responseGet = await HttpExecutioner.get(
//        requestURL:
//            'http://192.168.2.107:8080/user/${GlobalUser.globalUser.userName}',
//        headers: {
//          "content-type": "application/json",
//          'authorization': 'JWT ${GlobalUser.globalUser.id}'
//        },
//      );
//      if (responseGet.statusCode == 200) {
//        final userData = json.decode(responseGet.body);
//        String fullName =
//            userData['first_name'] + ' ' + userData['last_name'];
//        print('fullName: $fullName');
//
//        Navigator.push(
//          context,
//          MaterialPageRoute(
//              builder: (context) => UserScreen(fullName: fullName)),
//        );
//      }
//    } else {
//      ReusableAlert(
//        context: context,
//        title: 'Error',
//        desc: data['description'],
//      ).getAlert();
//    }
  }

  void onBackwardPressed() {
    Navigator.pop(context);
  }

  void onForgotPasswordPressed() {
    ReusableAlert(
      context: context,
      title: 'Forgot password??',
      desc: 'You should create new account',
    ).getAlert();
  }
}
