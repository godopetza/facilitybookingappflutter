import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

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