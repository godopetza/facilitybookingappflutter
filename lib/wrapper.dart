// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'package:facilities_booking_unionsuites/pages/home.dart';
import 'package:facilities_booking_unionsuites/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return either home or login
    // final user = Provider.of<User>(context);
    
    // return either the Home or Authenticate widget
    // if (user == null){
      return LoginScreen();
    // } else {
    //   return Home();
    // }
  }
}
