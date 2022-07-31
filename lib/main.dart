// ignore_for_file: prefer_const_constructors

import 'package:facilities_booking_unionsuites/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Wrapper(),
      // initialRoute: '/home',
      // routes: {
      //   '/':(context) => LoginScreen(),
      //   '/loading': (context) => Loading(),
      //   '/login': (context) => LoginScreen(),
      //   '/home': (context) => Home(),
      //   '/userProfile': (context) => UserProfile(),
      //   '/comingsoonbooking': (context) => CoomingSoon(),
      //   '/success': (context) => Success(),
      //   '/failed': (context) => FailedScreen(),
      //   '/resetPassword': (context) => ResetPassword(),
      // },
    );
  }
}
