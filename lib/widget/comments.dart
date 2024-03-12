import 'package:flutter/material.dart';

class MyComments extends StatelessWidget {
  final String comment;
  final String user;
  final String time;

  const MyComments(
      {super.key,
      required this.comment,
      required this.user,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(5)),
      child: Container(
        padding: EdgeInsets.all(6),
        margin: EdgeInsets.all(6),
        child: Center(
          child: Column(
            children: [
              Text(
                comment,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                user,
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                time,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
