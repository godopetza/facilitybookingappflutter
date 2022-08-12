import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facilities_booking_unionsuites/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import '../providers/auth.dart';
import 'package:json_annotation/json_annotation.dart';

class FacilityDetail2 extends StatefulWidget {
  final assetPath, facilityprice, facilityname, info;

  const FacilityDetail2({
    Key? key,
    this.facilityname,
    this.info,
    this.assetPath,
    this.facilityprice,
  }) : super(key: key);

  @override
  State<FacilityDetail2> createState() => _FacilityDetail2State();
}

class _FacilityDetail2State extends State<FacilityDetail2> {
  int _currentHours = 1;
  int totalAmount = 100;
  final now = DateTime.now();
  late BookingService myBookingService;

  final String uid = AuthService().currentUser!.uid;

  CollectionReference bookings =
      FirebaseFirestore.instance.collection('bookings');

  CollectionReference<SportBooking> getBookingStream(
      {required String placeId}) {
    return bookings
        .doc(placeId)
        .collection('bookings')
        .withConverter<SportBooking>(
          fromFirestore: (snapshots, _) =>
              SportBooking.fromJson(snapshots.data()!),
          toFirestore: (snapshots, _) => snapshots.toJson(),
        );
  }

  ///How you actually get the stream of data from Firestore with the help of the previous function
  ///note that this query filters are for my data structure, you need to adjust it to your solution.
  Stream<dynamic>? getBookingStreamFirebase(
      {required DateTime end, required DateTime start}) {
    return bookings
        .doc(widget.facilityname)
        .collection('bookings')
        .withConverter<SportBooking>(
            fromFirestore: (snapshots, _) =>
                SportBooking.fromJson(snapshots.data()!),
            toFirestore: (snapshots, _) => snapshots.toJson())
        .where('bookingStart', isGreaterThanOrEqualTo: start)
        .where('bookingStart',
            isLessThanOrEqualTo: end)
        .snapshots();
  }

  ///After you fetched the data from firestore, we only need to have a list of datetimes from the bookings:
  List<DateTimeRange> convertStreamResultFirebase(
      {required dynamic streamResult}) {
    List<DateTimeRange> converted = [];

    for (var i = 0; i < streamResult.size; i++) {
      final item = streamResult.docs[i].data();
      converted.add(
          DateTimeRange(start: (item.bookingStart!), end: (item.bookingEnd!)));
    }
    return converted;
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    //limit slots
    myBookingService = BookingService(
        serviceName: widget.facilityname,
        serviceDuration: 60,
        bookingEnd: DateTime(now.year, now.month, now.day, 20, 0),
        bookingStart: DateTime(now.year, now.month, now.day, 8, 0));
  }

  Widget _calculateTotal() {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Text('Total',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Varela',
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold)),
          Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text('RM ',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Varela',
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  )),
              Text('$totalAmount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Varela',
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          )
        ],
      ),
    );
  }

  Widget _bookingexplaination() {
    return Column(
      children: [
        SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                icon: Icon(
                  Icons.circle,
                  color: Colors.green[200],
                ),
                label: const Text('Available',
                    style: TextStyle(color: Colors.white)),
                onPressed: () {},
              ),
              TextButton.icon(
                icon: const Icon(
                  Icons.circle,
                  color: Colors.red,
                ),
                label: const Text('Unavailable',
                    style: TextStyle(color: Colors.white)),
                onPressed: () {},
              ),
            ],
          ),
        ),
        _calculateTotal(),
        const Divider(
          thickness: 1,
          color: Colors.white,
        ),
        const Text('HOURS',
                    style: TextStyle(color: Colors.white)),
        _pickhours(),
        const Divider(
          thickness: 1,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget _pickhours() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
            child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: const Color(0xff107163),
            borderRadius: BorderRadius.circular(50),
          ),
        )),
        NumberPicker(
          textStyle: const TextStyle(fontSize: 20.0, color: Colors.white),
          axis: Axis.horizontal,
          selectedTextStyle: const TextStyle(
              fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),
          value: _currentHours,
          itemHeight: 45,
          itemWidth: 45,
          maxValue: 4,
          itemCount: 7,
          minValue: 1,
          onChanged: (v) {
            setState(() {
              _currentHours = v;
              int sum = (int.parse(widget.facilityprice) * _currentHours) + 100;
              totalAmount = sum;
            });
          },
        ),
      ],
    );
  }

  Future<dynamic> uploadBooking({required BookingService newBooking}) async {
    final uploadedBooking = SportBooking(
      email: 'email',
      phoneNumber: 'phoneNumber',
      placeAddress: 'placeAddress',
      bookingStart: newBooking.bookingStart,
      placeId: widget.facilityname,
      userId: uid,
      userName: 'userName',
      serviceName: widget.facilityname,
      serviceDuration: _currentHours * 60,
      servicePrice: totalAmount,
    );

    await Future.delayed(const Duration(seconds: 1));
    await bookings
        .doc(widget.facilityname)
        .collection('bookings')
        .add(uploadedBooking.toJson());
    // .catchError((error) => print("failed booking: $error"));
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
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: ListView(children: [
            Hero(
              tag: widget.assetPath,
              child: Container(
                height: 150.0,
                width: 150.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: Svg(widget.assetPath), fit: BoxFit.contain)),
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: Text('RM ${widget.facilityprice}',
                  style: const TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF17532))),
            ),
            const SizedBox(height: 10.0),
            Center(
              child: Text(widget.facilityname,
                  style: const TextStyle(
                      color: Color(0xFF575E67),
                      fontFamily: 'Varela',
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 50.0,
                child: Text(
                    //facilityinfo
                    widget.info,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: 'Varela',
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Color(0xFFB4B8B9))),
              ),
            ),
            const SizedBox(height: 20.0),
            //Dates
            Container(
              width: MediaQuery.of(context).size.width - 50.0,
              margin: const EdgeInsets.only(left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat.yMMMMd().format(DateTime.now()),
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Varela',
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  const Text(
                    'Today',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            //picking dates
            Center(
              child: Container(
                margin: const EdgeInsets.only(
                    left: 30.0, right: 30.0, bottom: 10.0),
                height: MediaQuery.of(context).size.height * 0.9,
                child: BookingCalendar(
                  bookingService: myBookingService,
                  getBookingStream: getBookingStreamFirebase,
                  uploadBooking: uploadBooking,
                  convertStreamResultToDateTimeRanges:
                      convertStreamResultFirebase,
                  bookingExplanation: _bookingexplaination(),
                ),
              ),
            ),
            const SizedBox(height: 200.0),
          ]),
        ),
      ),
    );
  }
}

class AppUtil {
  static DateTime timeStampToDateTime(Timestamp timestamp) {
    return DateTime.parse(timestamp.toDate().toString());
  }

  static Timestamp dateTimeToTimeStamp(DateTime? dateTime) {
    return Timestamp.fromDate(dateTime ?? DateTime.now()); //To TimeStamp
  }
}

@JsonSerializable(explicitToJson: true)
class SportBooking {
  /// The generated code assumes these values exist in JSON.
  final String? userId;
  final String? userName;
  final String? placeId;
  final String? serviceName;
  final int? serviceDuration;
  final int? servicePrice;

  @JsonKey(
      fromJson: AppUtil.timeStampToDateTime,
      toJson: AppUtil.dateTimeToTimeStamp)
  final DateTime? bookingStart;
  @JsonKey(
      fromJson: AppUtil.timeStampToDateTime,
      toJson: AppUtil.dateTimeToTimeStamp)
  final DateTime? bookingEnd;
  final String? email;
  final String? phoneNumber;
  final String? placeAddress;

  SportBooking(
      {this.email,
      this.phoneNumber,
      this.placeAddress,
      this.bookingStart,
      this.bookingEnd,
      this.placeId,
      this.userId,
      this.userName,
      this.serviceName,
      this.serviceDuration,
      this.servicePrice});

  /// Connect the generated [_$SportBookingFromJson] function to the `fromJson`
  /// factory.
  factory SportBooking.fromJson(Map<String, dynamic> json) => SportBooking(
        email: json['email'] as String?,
        phoneNumber: json['phoneNumber'] as String?,
        placeAddress: json['placeAddress'] as String?,
        bookingStart:
            AppUtil.timeStampToDateTime(json['bookingStart'] as Timestamp),
        bookingEnd:
            AppUtil.timeStampToDateTime(json['bookingEnd'] as Timestamp),
        placeId: json['placeId'] as String?,
        userId: json['userId'] as String?,
        userName: json['userName'] as String?,
        serviceName: json['serviceName'] as String?,
        serviceDuration: json['serviceDuration'] as int?,
        servicePrice: json['servicePrice'] as int?,
      );

  get minutes => serviceDuration;

  /// Connect the generated [_$SportBookingToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => {
        'email': email,
        'phoneNumber': phoneNumber,
        'placeAddress': placeAddress,
        'bookingStart': bookingStart,
        'bookingEnd': bookingStart!.add(Duration(minutes: minutes)),
        'placeId': placeId,
        'userId': userId,
        'userName': userName,
        'serviceName': serviceName,
        'serviceDuration': serviceDuration,
        'servicePrice': servicePrice,
      };
}
