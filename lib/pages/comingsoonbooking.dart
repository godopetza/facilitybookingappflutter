// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class CoomingSoon extends StatefulWidget {
  const CoomingSoon({Key? key}) : super(key: key);

  @override
  State<CoomingSoon> createState() => _CoomingSoonState();
}

class _CoomingSoonState extends State<CoomingSoon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Image(
                image: Svg('assets/images/under_construction.svg'),
                height: 250.0,
                width: 250.0,
              ),
              Text(
                'Under Construction',
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
