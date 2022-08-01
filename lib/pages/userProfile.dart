// ignore_for_file: prefer_const_constructors

import 'package:facilities_booking_unionsuites/providers/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../bottom_bar.dart';

class UserProfile extends StatelessWidget {
  UserProfile({Key? key}) : super(key: key);

  final User? user = AuthService().currentUser;

  Future<void> signOut() async {
    await AuthService().signOut();
  }

  Widget _userUid() {
    return Text(
      user?.email ?? "User Email",
      style: TextStyle(color: Colors.white),
    );
  }

  // Widget _signOutButton() {
  //   return ElevatedButton(onPressed: signOut, child: const Text('Sign Out'));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: TextButton.icon(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: Text('Logout', style: TextStyle(color: Colors.white)),
              onPressed: () {
                signOut();
              },
            ),
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(
                height: 30.0,
              ),
              _userUid(),
              // _signOutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
