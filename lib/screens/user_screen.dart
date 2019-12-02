import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StatefulUserScreen(),
    );
  }
}

class StatefulUserScreen extends StatefulWidget {
  @override
  _StatefulUserScreenState createState() => _StatefulUserScreenState();
}

class _StatefulUserScreenState extends State<StatefulUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('abc'),
      ),
    );
  }
}
