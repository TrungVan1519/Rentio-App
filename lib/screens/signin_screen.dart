import 'package:flutter/material.dart';
import 'package:rentio/components/reusable_alert.dart';
import 'package:rentio/components/reusable_gradient_button_card.dart';
import 'package:rentio/components/reusable_loading_card.dart';
import 'package:rentio/local_json_getter/sign_in_json_getter.dart';
import 'package:rentio/screens/user_screen.dart';
import 'package:rentio/utilities/constants.dart';

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
  int displayedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      body: IndexedStack(
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
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
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
                      fontSize: kFontTextSize,
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
                          fontSize: kFontTextSize,
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
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            _hidePassword ? 'SHOW' : 'HIDE',
                            style: TextStyle(
                              color: Color(kGradientColorElement1),
                              fontSize: kFontTextSize,
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

    var data = await JsonGetter(jsonNameFile: 'data/login.json').loadData();
    // Dong data nay de truyen sang User_Screen
    var fullNameData =
        await JsonGetter(jsonNameFile: 'data/signup.json').loadData();
    String fullName =
        fullNameData['firstname'] + ' ' + fullNameData['lastname'];
    print(fullName);

    if (data != null) {
      if (_userNameController.text.compareTo(data['username']) == 0) {
        _userNameValid = true;
      } else {
        _userNameValid = false;
      }

      if (_passwordController.text.compareTo(data['password']) == 0) {
        _passwordValid = true;
      } else {
        _passwordValid = false;
      }

      if (_userNameValid && _passwordValid) {
        isLoading = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserScreen(
              fullName: fullName,
            ),
          ),
        );

        setState(() {
          isLoading = false;
        });
      } else {
        ReusableAlert(
          context: context,
          title: 'Not exist',
          desc: 'Your account is not exist',
        ).getAlert();

        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void onBackwardPressed() {
    Navigator.pop(context);
  }

  void onForgotPasswordPressed() {
    ReusableAlert(
            context: context,
            title: 'Forgot password??',
            desc: 'You should create new account')
        .getAlert();
  }
}
