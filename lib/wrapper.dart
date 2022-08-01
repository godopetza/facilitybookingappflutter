import 'package:facilities_booking_unionsuites/pages/login.dart';
import 'package:facilities_booking_unionsuites/providers/auth.dart';
import 'package:flutter/material.dart';

import 'bottom_bar.dart';
import 'pages/userProfile.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthService().authStateChanges,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return const BottomBar();
          } else {
            return const LoginScreen();
          }
        }
      ),
    );
  }
}
