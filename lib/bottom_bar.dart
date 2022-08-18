// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:facilities_booking_unionsuites/pages/comingsoonbooking.dart';
import 'package:facilities_booking_unionsuites/pages/user_profile.dart';
import 'package:flutter/material.dart';

import 'pages/chats_page.dart';
import 'pages/home.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final PageController _myPage = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CoomingSoon()),
          );
        },
        backgroundColor: Color(0xFFF17532),
        child: Icon(Icons.notifications_none),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 6.0,
          color: Colors.black,
          elevation: 9.0,
          clipBehavior: Clip.antiAlias,
          child: Container(
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0)),
                // color: Colors.white
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width / 2 - 40.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: <Widget>[
                            //home
                            IconButton(
                              icon: Icon(Icons.home_outlined,
                                  color: Colors.white),
                              onPressed: () {
                                setState(() {
                                  _myPage.jumpToPage(0);
                                });
                              },
                            ),
                            //person_outline
                            IconButton(
                              icon: Icon(Icons.person_outline,
                                  color: Colors.white),
                              onPressed: () {
                                setState(() {
                                  _myPage.jumpToPage(1);
                                });
                              },
                            ),
                          ],
                        )),
                    Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width / 2 - 40.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: <Widget>[
                            //search
                            IconButton(
                              icon: Icon(Icons.messenger_outline_sharp, color: Colors.white),
                              onPressed: () {
                                setState(() {
                                  _myPage.jumpToPage(2);
                                });
                              },
                            ),
                            //favorite_border
                            IconButton(
                              icon: Icon(Icons.favorite_border,
                                  color: Colors.white),
                              onPressed: () {
                                setState(() {
                                  _myPage.jumpToPage(3);
                                });
                              },
                            ),
                          ],
                        )),
                  ]))),
      body: PageView(
        controller: _myPage,
        // This will print in your console to show page changes for testing
        // onPageChanged: (int) {
        //   print('Page Changes to index $int');
        // },
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Home(),
          UserProfile(),
          ChatsPage(),
          CoomingSoon()
        ], // Comment this if you need to use Swipe.
      ),
    );
  }
}
