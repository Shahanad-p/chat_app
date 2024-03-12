import 'package:flutter/material.dart';

class MyImagePath extends StatelessWidget {
  final String imagePath;
  final void Function()? onTap;

  const MyImagePath({super.key, required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: Image.asset(imagePath),
          ),
        ],
      ),
    );
  }
}
