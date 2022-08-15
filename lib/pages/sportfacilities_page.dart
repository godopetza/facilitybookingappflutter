// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:favorite_button/favorite_button.dart';

import 'facility_detail.dart';

class FacilityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        children: <Widget>[
          SizedBox(height: 15.0),
          Container(
              padding: EdgeInsets.only(right: 15.0),
              width: MediaQuery.of(context).size.width - 30.0,
              height: MediaQuery.of(context).size.height - 50.0,
              child: GridView.count(
                crossAxisCount: 2,
                primary: false,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 0.8,
                children: <Widget>[
                  _buildCard(
                      'Futsal Pitch',
                      '100',
                      'assets/images/futsal.svg',
                      false,
                      'Pitch available everyday from 9AM to 1AM. Can bring in 9 Guests per game.',
                      context),
                  _buildCard('Badminton Pitch', '50',
                      'assets/images/badminton.svg', false, '', context),
                ],
              )),
          SizedBox(height: 15.0)
        ],
      ),
    );
  }

  Widget _buildCard(String name, String price, String imgPath, bool isFavorite,
      String info, context) {
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 19.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FacilityDetail2(
                        assetPath: imgPath,
                        facilityprice: price,
                        facilityname: name,
                        info: info,
                      )));
            },
            child: Container(
                decoration: BoxDecoration(
                    // can add bg for container
                    //           image: DecorationImage(
                    // image: AssetImage("assets/images/putimghere.jpg"),
                    // fit: BoxFit.cover)
                    borderRadius: BorderRadius.circular(18.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                    color: Colors.white),
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FavoriteButton(
                              iconSize: 25.0,
                              isFavorite: false,
                              iconDisabledColor: Color.alphaBlend(
                                  Colors.black12, Colors.white),
                              valueChanged: (_isFavorite) {
                                isFavorite = _isFavorite;
                              },
                            ),
                          ])),
                  SizedBox(
                    height: 8.0,
                  ),
                  Hero(
                      tag: imgPath,
                      child: Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: Svg(imgPath), fit: BoxFit.contain)))),
                  SizedBox(height: 7.0),
                  Text('RM $price',
                      style: TextStyle(
                          color: Color(0xFFCC8053),
                          fontFamily: 'Varela',
                          fontSize: 20.0)),
                  Text(name,
                      style: TextStyle(
                          color: Color(0xFF575E67),
                          fontFamily: 'Varela',
                          fontSize: 20.0)),
                ]))));
  }
}
