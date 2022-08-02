// ignore_for_file: prefer_const_constructors

import 'package:facilities_booking_unionsuites/pages/comingsoonbooking.dart';
import 'package:flutter/material.dart';
import 'ent_facilities_page.dart';
import 'sportfacilities_page.dart';
import 'study_facilities_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> 
with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
            body: SafeArea(
              child: ListView(
                    padding: EdgeInsets.only(left: 20.0),
                    children: <Widget>[
                      SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            'Categories',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Varela',
                              fontSize: 42.0,
                              fontWeight: FontWeight.bold
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: GestureDetector(
                              onTap: () {
                                //make history page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const CoomingSoon()),
                                );
                              },
                              child: Text(
                                'History',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Varela',
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.bold,
                                )
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 15.0),
                      TabBar(
                controller: _tabController,
                indicatorColor: Colors.transparent,
                labelColor: Colors.orange,
                isScrollable: true,
                labelPadding: EdgeInsets.only(right: 45.0),
                unselectedLabelColor: Color(0xFFCDCDCD),
                // ignore: prefer_const_literals_to_create_immutables
                tabs: [
                  Tab(
                    child: Text('Sports',
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 21.0,
                        )),
                  ),
                  Tab(
                    child: Text('Entertainment',
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 21.0,
                        )),
                  ),
                  Tab(
                    child: Text('Study',
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 21.0,
                        )),
                  )
                ]),
                //show facilities here
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      FacilityPage(),
                      Ent_facilities_page(),
                      Study_facilities_page(),
                    ],
                  ),
                )
            
                    ],
                  ),
            ),
    );
  }
}
