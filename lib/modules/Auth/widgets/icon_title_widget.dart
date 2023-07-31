import 'package:flutter/material.dart';
import 'package:clinic_app/utils/constants/image_konstants.dart';

List<Widget> buildIconAndTitle(
    {required String titleText,
    required double height,
    BuildContext? context}) {
  return [
    Padding(
      padding: const EdgeInsets.only(top: 10),
      child: context != null
          ? SizedBox(
              height: MediaQuery.of(context).size.height * 0.16,
              width: MediaQuery.of(context).size.height * 0.16,
              child: Image.asset(
                ImagesConstants.jatyaLogoName,
                // height: height,
                fit: BoxFit.contain,
              ),
            )
          : Image.asset(
              ImagesConstants.jatyaLogoName,
              height: height,
              fit: BoxFit.cover,
            ),
    ),
    const SizedBox(height: 50.0),
    Text(
      titleText,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  ];
}
