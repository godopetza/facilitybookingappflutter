// ignore_for_file: prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, unnecessary_new
// This has razorpay api integrated
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:facilities_booking_unionsuites/pages/failed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';
import '../providers/auth.dart';

class FacilityDetail extends StatefulWidget {
  final assetPath, facilityprice, facilityname, info;

  FacilityDetail({
    this.assetPath,
    this.facilityprice,
    this.facilityname,
    this.info,
  });

  @override
  State<FacilityDetail> createState() => _FacilityDetailState();
}

class _FacilityDetailState extends State<FacilityDetail> {
  late Razorpay razorpay;

  final DatePickerController _dateController = DatePickerController();

  late DateTime _selectedDate = DateTime.now();

  TimeOfDay _timeOfDay = TimeOfDay(hour: 0, minute: 00);
  int _currentHours = 1;
  String totalAmount = "100";

  final String uid = AuthService().currentUser!.uid;

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _timeOfDay = value!;
      });
    });
  }

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
      "amount": totalAmount * 100,
      "name": "UnionSuites",
      "description": 'payment for ${widget.facilityname}',
      "prefill": {"contact": "9834555555", "email": "user@union.suite"},
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
          child: Text('RM ${widget.facilityprice}',
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
        //Dates
        Container(
          width: MediaQuery.of(context).size.width - 50.0,
          margin: EdgeInsets.only(left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Varela',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              Text(
                'Today',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
        SizedBox(height: 20.0),
        //picking dates
        Container(
          margin: EdgeInsets.only(left: 30.0, right: 30.0),
          height: 90.0,
          child: DatePicker(
            DateTime.now(),
            controller: _dateController,
            initialSelectedDate: DateTime.now(),
            selectionColor: Color(0xff107163),
            selectedTextColor: Colors.white,
            dateTextStyle: TextStyle(fontSize: 15.0, color: Colors.white24),
            monthTextStyle: TextStyle(fontSize: 10.0, color: Colors.white),
            dayTextStyle: TextStyle(fontSize: 10.0, color: Colors.white70),
            onDateChange: (selectedDate) {
              setState(() {
                _selectedDate = selectedDate;
              });
            },
          ),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 30),
            child: Text(
              'Start Time',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Center(
          child: Container(
              margin: EdgeInsets.only(top: 20),
              child: GestureDetector(
                onTap: _showTimePicker,
                child: Text(
                  _timeOfDay.format(context).toString(),
                  style: TextStyle(
                    fontSize: 50.0,
                    color: Colors.white,
                  ),
                ),
              )),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 30, bottom: 20.0),
            child: Text(
              'Hours',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Color(0xff107163),
                  borderRadius: BorderRadius.circular(50),
                ),
              )),
              Container(
                  child: NumberPicker(
                textStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                axis: Axis.horizontal,
                selectedTextStyle: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                value: _currentHours,
                itemHeight: 45,
                itemWidth: 45,
                maxValue: 4,
                itemCount: 7,
                minValue: 1,
                onChanged: (v) {
                  setState(() {
                    _currentHours = v;
                    int sum =
                        (int.parse(widget.facilityprice) * _currentHours) + 100;
                    totalAmount = sum.toString();
                  });
                },
              )),
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
                    Text(totalAmount,
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
            savebooking(
              uid: uid,
              selectedDate: _selectedDate,
              hours: _currentHours,
              facility: widget.facilityname,
              starttime: _timeOfDay,
            );
            // openCheckout();
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
    );
  }

  Future savebooking({
    required DateTime selectedDate,
    required int hours,
    required String facility,
    required TimeOfDay starttime,
    required String uid,
  }) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String bookingDate = formatter.format(selectedDate);

    //Reference to database
    final docUser = FirebaseFirestore.instance
        .collection('bookings')
        .doc(uid)
        .collection(facility);

    final user = User(
        id: docUser.id,
        uid: uid,
        facility: facility,
        starttime: starttime.format(context).toString(),
        hours: hours,
        selectedDate: bookingDate);

    final json = user.toJson();

    // Create document and write data to firebase
    await docUser.add(json);
  }
}

// User model for saving data

class User {
  String id;
  String uid;
  String selectedDate;
  int hours;
  String facility;
  String starttime;

  User({
    this.id = '',
    required this.uid,
    required this.selectedDate,
    required this.hours,
    required this.facility,
    required this.starttime,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'facility': facility,
        'starttime': starttime,
        'hours': hours,
        'selectedDate': selectedDate
      };
}
