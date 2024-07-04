import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  final String imagePath;
  final String heading;
  final String sub_heading;
  const IntroScreen(
      {super.key,
      required this.imagePath,
      required this.heading,
      required this.sub_heading});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          height: 350,
          width: 350,
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          heading,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 28,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          sub_heading,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}
