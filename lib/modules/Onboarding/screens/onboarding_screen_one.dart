// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:clinic_app/utils/constants/image_konstants.dart';

class OnboardingScreenOne extends StatelessWidget {
  const OnboardingScreenOne({Key? key}) : super(key: key);

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
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Text(
                "Find the best doctors in your city",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.black,
                    fontFamily: 'Proxima Nova'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "With the help of our intelligent algorithms,\nnow locate the best doctors around\nyour city at total ease",
                textAlign: TextAlign.center,
                maxLines: 3,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Image.asset(
              ImagesConstants.onboardingone,
              // height: devicesize.height / 2.5,
              width: devicesize.width * 0.70,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0)
          ],
        ),
      ),
    );
  }
}
