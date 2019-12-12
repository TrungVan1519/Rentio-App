import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CubeGridLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitCubeGrid(
      color: Colors.brown,
      size: 50.0,
      duration: Duration(seconds: 1),
    );
  }
}
