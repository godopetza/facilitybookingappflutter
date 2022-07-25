// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          SizedBox(height: 500.0,),
          SpinKitCircle(
            color: Colors.orange,
            size: 50.0,
          ),
          SizedBox(height: 20.0,),
          Text(
            'loading',
          style: TextStyle(color: Colors.white, fontSize: 20.0)
          ),
        ],
      ),
    );
  }
}
