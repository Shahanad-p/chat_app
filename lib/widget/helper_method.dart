import 'package:cloud_firestore/cloud_firestore.dart';

String formatDate(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  // Get year
  String year = dateTime.year.toString();
  // Get month
  String month =
      dateTime.month.toString().padLeft(2, '0'); // Ensure two digits for month
  // Get day
  String day =
      dateTime.day.toString().padLeft(2, '0'); // Ensure two digits for day
  // Get hours
  String hour =
      dateTime.hour.toString().padLeft(2, '0'); // Ensure two digits for hour
  // Get minutes
  String minute = dateTime.minute
      .toString()
      .padLeft(2, '0'); // Ensure two digits for minute
  // Final formatted date with time
  String formattedDateTime = '$day/$month/$year $hour:$minute';
  return formattedDateTime;
}
