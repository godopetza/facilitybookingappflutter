// ignore_for_file: prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, unnecessary_new

import 'package:facilities_booking_unionsuites/bottom_bar.dart';
import 'package:facilities_booking_unionsuites/pages/failed.dart';
import 'package:facilities_booking_unionsuites/pages/success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';
class FacilityDetail extends StatefulWidget {
  final assetPath, facilityprice, facilityname, info;

  FacilityDetail(
      {this.assetPath, this.facilityprice, this.facilityname, this.info});

  @override
  State<FacilityDetail> createState() => _FacilityDetailState();
}

class _FacilityDetailState extends State<FacilityDetail> {
  late Razorpay razorpay;

  @override
  void initState() {
    super.initState();

    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerPaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void handlerPaymentSuccess() {
    Toast.show("Booking Success", duration: Toast.lengthLong);
  }

  void handlerPaymentError() {
    Toast.show("Error in Payment", duration: Toast.lengthLong);
  }

  void handlerExternalWallet() {
    Toast.show("Extrenal Wallet", duration: Toast.lengthLong);
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_b0dKgBYsBlwXaL",
      "amount": 20000,
      "name": "UnionSuites",
      "description": "Payment for facility",
      "prefill": {"contact": "2323232323", "email": "union@gmail.com"},
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FailedScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(children: [
        SizedBox(height: 15.0),
        Hero(
            tag: widget.assetPath,
            child: Image(
                image: Svg(widget.assetPath),
                // height: 150.0,
                // width: 100.0,
                fit: BoxFit.contain)),
        SizedBox(height: 20.0),
        Center(
          child: Text(widget.facilityprice,
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF17532))),
        ),
        SizedBox(height: 10.0),
        Center(
          child: Text(widget.facilityname,
              style: TextStyle(
                  color: Color(0xFF575E67),
                  fontFamily: 'Varela',
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 20.0),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 50.0,
            child: Text(
                //facilityinfo
                widget.info,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Color(0xFFB4B8B9))),
          ),
        ),
        SizedBox(height: 20.0),
        //Available dates+time
        //month, year
        Container(
          width: MediaQuery.of(context).size.width - 50.0,
          margin: EdgeInsets.only(left: 30),
          child: Text(
            'July 2022',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Varela',
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
        SizedBox(height: 20.0),
        //picking dates
        Container(
          height: 90.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              dates('Sun', '24', true),
              dates('Mon', '25', false),
              dates('Tue', '26', false),
              dates('Wed', '27', false),
              dates('Thu', '28', false),
              dates('Fri', '29', false),
              dates('Sat', '30', false)
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, top: 30),
          child: Text(
            'Start',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 20),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 2.7,
            children: [
              facilityTimingsData("08:30 AM", true),
              facilityTimingsData("08:30 AM", false),
              facilityTimingsData("08:30 AM", false),
              facilityTimingsData("08:30 AM", false),
              facilityTimingsData("08:30 AM", false),
              facilityTimingsData("08:30 AM", false),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 25, top: 30),
          child: Text(
            'Duration',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 20),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 2.6,
            children: [
              facilityTimingsHours('', true),
              facilityTimingsHours('', false),
            ],
          ),
        ),
        SizedBox(height: 30.0),
        Padding(
          padding: const EdgeInsets.only(right: 25.0, left: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text('Total',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Varela',
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold)),
              Container(
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text('RM ',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Varela',
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(
                        '200',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Varela',
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 20.0),
        Center(
            child: GestureDetector(
          onTap: () {
            openCheckout();
          },
          child: Container(
              margin: EdgeInsets.only(bottom: 50),
              width: MediaQuery.of(context).size.width - 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0), color: Colors.red),
              child: Center(
                  child: Text(
                'BOOK',
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ))),
        ))
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xFFF17532),
        child: Icon(Icons.notifications_none),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
    );
  }

  totalamount() {}

  dates(String day, String date, bool isSelected) {
    return isSelected
        ? Container(
            width: 70,
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    day,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(7),
                  child: Text(
                    date,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )
        : Container(
            width: 70,
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: Color(0xffEEEEEE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    day,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(7),
                  child: Text(
                    date,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
  }

  Widget facilityTimingsData(String time, bool isSelected) {
    return isSelected
        ? Container(
            margin: EdgeInsets.only(left: 20, top: 10),
            decoration: BoxDecoration(
              color: Color(0xff107163),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 2),
                  child: Icon(
                    Icons.access_time,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 2),
                  child: Text(
                    '08:30 AM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            margin: EdgeInsets.only(left: 20, top: 10),
            decoration: BoxDecoration(
              color: Color(0xffEEEEEE),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 2),
                  child: Icon(
                    Icons.access_time,
                    color: Colors.black,
                    size: 18,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 2),
                  child: Text(
                    '08:30 AM',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Widget facilityTimingsHours(String time, bool isSelected) {
    return isSelected
        ? Container(
            margin: EdgeInsets.only(left: 20, top: 10),
            decoration: BoxDecoration(
              color: Color(0xff107163),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 2),
                  child: Icon(
                    Icons.timelapse,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 2),
                  child: Text(
                    '1 HOUR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            margin: EdgeInsets.only(left: 20, top: 10),
            decoration: BoxDecoration(
              color: Color(0xffEEEEEE),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 2),
                  child: Icon(
                    Icons.timelapse,
                    color: Colors.black,
                    size: 18,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 2),
                  child: Text(
                    '2 HOURS',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
