// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Success extends StatefulWidget {
  const Success({Key? key}) : super(key: key);

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
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
              child: CircleAvatar(backgroundColor: Colors.green,
              radius: 150, child: Icon(Icons.check, color: Colors.black, size: 150.0,),)
            ),
            SizedBox(height: 30.0),
            Text(
              'Successful', 
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                ),
                ),
          ],
        ),
      ),
    );
  }
}
