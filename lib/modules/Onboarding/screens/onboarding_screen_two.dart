// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../../utils/constants/image_konstants.dart';

class OnboardingScreenTwo extends StatelessWidget {
  const OnboardingScreenTwo({super.key});

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
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              "Schedule appointments with expert doctors",
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
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Find experienced specialist doctors with expert\nratings and reviews and book your\nappointment hassle-free.",
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
          Image.asset(
            ImagesConstants.onboardingtwo,
            width: devicesize.width * 0.70,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 16),
        ],
      ),
    ));
  }
}
