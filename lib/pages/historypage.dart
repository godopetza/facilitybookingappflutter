import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import '../models/appUtil.dart';
import '../providers/auth.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final String uid = AuthService().currentUser!.uid;
  DateFormat dateFormat1 = DateFormat('EEE, dd-MMM-yyyy, HH:mm');
  DateFormat timeFormat = DateFormat('HH:mm');
  List<String> services = [
    'Futsal Pitch',
    'Badminton Pitch',
    'Arcade Room',
    'Theater Room',
    'Study Room'
  ];
  String? selectedItem = 'Badminton Pitch';

  Stream<List<SportBooking>> readBooking() => FirebaseFirestore.instance
      .collection('bookings')
      .doc(selectedItem)
      .collection('bookings')
      .where('userId', isEqualTo: uid)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => SportBooking.fromJson(doc.data()))
          .toList());

  Widget buildBooking(SportBooking booking) => ListTile(
        leading: CircleAvatar(
            child: Text(
          '${booking.serviceDuration}',
          style: const TextStyle(color: Colors.white),
        )),
        title: Text(
          '${booking.serviceName}',
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          '${dateFormat1.format(DateTime.parse(booking.bookingStart!.toIso8601String()))} -  ${timeFormat.format(DateTime.parse(booking.bookingEnd!.toIso8601String()))}',
          style: const TextStyle(color: Colors.white),
        ),
        //  DateTime.parse(timestamp.toDate().toString())
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          'History',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: selectedItem,
            items: services
                .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item,
                        style: const TextStyle(
                            fontSize: 15, color: Colors.white))))
                .toList(),
            onChanged: (item) => setState(() => selectedItem = item),
            icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.white),
            dropdownColor: Colors.black,
          ),
          StreamBuilder<List<SportBooking>>(
              stream: readBooking(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong! ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final booking = snapshot.data!;
                  return ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: booking.map(buildBooking).toList(),
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
    );
  }
}
