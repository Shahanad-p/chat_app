import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;
  const MyTextBox({
    super.key,
    required this.text,
    required this.sectionName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      margin: EdgeInsets.only(left: 40, right: 40),
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 230, 225, 225),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //section name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 144, 141, 141)),
              ),
              IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    Icons.edit,
                    color: Colors.grey,
                  ))
            ],
          ),

          //texts
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
