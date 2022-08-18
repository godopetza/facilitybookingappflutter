import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../providers/auth.dart';
import 'chatdetail.dart';

class ChatsPage extends StatefulWidget {
  ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  String uid = AuthService().currentUser!.uid;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void createUserInFirestore() {
    users
        .where('uid', isEqualTo: uid)
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        users.add({
          'email': AuthService().currentUser!.email,
          'uid': uid,
          'status': 'Available',
          'role': 'Resident'
        });
      }
    }).catchError((error) {});
  }

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .where('role', isEqualTo: 'Staff')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

  Widget buildUser(User user) => ListTile(
        onTap: () {
          callChatDetailScreen(context, '${user.email}', '${user.userId}');
        },
        title: Text(
          '${user.email}',
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          '${user.status}',
          style: const TextStyle(color: Colors.green),
        ),
      );

  void callChatDetailScreen(BuildContext context, String name, String uid) {
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) =>
                ChatDetail(friendUid: uid, friendName: name)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            //Button to add data first before chat -> Call create userinfirebase first
            Center(
              child: TextButton.icon(
                icon: const Icon(
                  Icons.ads_click,
                  color: Colors.white,
                ),
                label: const Text('First Time Click Here!',
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  createUserInFirestore();
                },
              ),
            ),

            StreamBuilder<List<User>>(
                stream: readUsers(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong! ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final users = snapshot.data!;
                    return ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: users.map(buildUser).toList(),
                    );
                  } else {
                    return const Center(
                      child: SpinKitCircle(
                        color: Colors.orange,
                        size: 50.0,
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class User {
  /// The generated code assumes these values exist in JSON.
  final String? email;
  final String? role;
  final String? status;
  final String? userId;

  User({
    this.email,
    this.userId,
    this.role,
    this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json['email'] as String?,
        userId: json['uid'] as String?,
        role: json['role'] as String?,
        status: json['status'] as String?,
      );
}
