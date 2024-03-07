import 'package:flutter/material.dart';

class MyComments extends StatelessWidget {
  final String text;
  final String user;
  final String time;

  const MyComments(
      {super.key, required this.text, required this.user, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          //comment
          Text(text),
          //user, time
          Row(
            children: [
              Text(user),
              Text(' . '),
              Text(time),
            ],
          )
        ],
      ),
    );
  }
}
