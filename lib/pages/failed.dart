// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class FailedScreen extends StatefulWidget {
  const FailedScreen({Key? key}) : super(key: key);

  @override
  State<FailedScreen> createState() => _FailedScreenState();
}

class _FailedScreenState extends State<FailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120.0),
              child: CircleAvatar(backgroundColor: Colors.red,
              radius: 150, child: Icon(Icons.close, color: Colors.black, size: 150.0,),)
            ),
            SizedBox(height: 30.0),
            //Error pop text
            Text(
              'Error', 
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                ),
                ),
            // Error msg 
            Text(
              'Error message goes here!', 
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                // fontSize: 30.0,
                ),
                ),
          ],
        ),
      ),
    );
  }
}
