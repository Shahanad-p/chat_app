//return the formated data as string
import 'package:cloud_firestore/cloud_firestore.dart';

String formatDate(Timestamp timestamp) {
  //Timestamb is the object we retrive from the firebase
  //so to desplay it , lets convert it to a string
  DateTime dateTime = timestamp.toDate();
  //get year
  String year = dateTime.year.toString();
  //get month
  String month = dateTime.month.toString();
  //get day
  String day = dateTime.day.toString();
  //final formated date
  String formatedData = '$day/$month/$year';
  return formatedData;
}
