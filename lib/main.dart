// ignore_for_file: prefer_const_constructors

import 'package:facilities_booking_unionsuites/pages/comingsoonbooking.dart';
import 'package:facilities_booking_unionsuites/pages/login.dart';
import 'package:facilities_booking_unionsuites/pages/success.dart';
import 'package:flutter/material.dart';
import 'package:facilities_booking_unionsuites/pages/loading.dart';
import 'package:facilities_booking_unionsuites/pages/failed.dart';
import 'package:facilities_booking_unionsuites/pages/home.dart';
import 'package:facilities_booking_unionsuites/pages/userProfile.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(context) => LoginScreen(),
        '/loading': (context) => Loading(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => Home(),
        '/userProfile': (context) => UserProfile(),
        // '/futsalbooking': (context) => Futsalbooking(),
        '/comingsoonbooking': (context) => CoomingSoon(),
        '/success': (context) => Success(),
        '/failed': (context) => FailedScreen(),
      },
    ),
    );
