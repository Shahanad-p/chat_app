import 'package:flutter/material.dart';

class ImagePath extends StatelessWidget {
  const ImagePath({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: 40,
          width: 40,
          // child: Image.asset('assets/code.png'),
        ),
        SizedBox(
          height: 40,
          width: 40,
          // child: Image.asset('assets/google.png'),
        ),
        SizedBox(
          height: 40,
          width: 40,
          child: InkWell(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => OtpStartingScreen()));
            },
            // child: Image.asset('assets/mobile-phone.png'),
          ),
        )
      ],
    );
  }
}
