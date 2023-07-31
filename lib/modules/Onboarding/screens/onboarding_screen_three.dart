// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../utils/constants/image_konstants.dart';

class OnboardingScreenThree extends StatelessWidget {
  const OnboardingScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    var devicesize = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              ImagesConstants.jatyaLogoName,
              height: devicesize.height / 10,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Meet doctors at your home virtually",
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Text(
                "Can't go to the hospital? Book video call\nappointments with your preferred doctor\nwithin few minutes.",
                textAlign: TextAlign.center,
                maxLines: 3,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Image.asset(
                ImagesConstants.onboardingthree,
                width: devicesize.width * 0.60,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
