import 'package:facilities_booking_unionsuites/providers/auth.dart';
import 'package:facilities_booking_unionsuites/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  UserProfile({Key? key}) : super(key: key);

  final User? user = AuthService().currentUser;

  Future<void> signOut() async {
    await AuthService().signOut();
    const Wrapper();
  }

  Widget _userUid() {
    return Text(
      user?.email ?? "User Email",
      style: const TextStyle(color: Colors.white),
    );
  }

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
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: const Text('Logout', style: TextStyle(color: Colors.white)),
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
              const SizedBox(
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
