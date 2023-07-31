import 'package:flutter/material.dart';

import 'custom_text_button.dart';

Padding bulletPoint() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: 5.0,
        width: 5.0,
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
      ),
    );

List<Widget> buildTermsAndCopyrightWidget(
    {required Function() termsOnPressed,
    required Function() privacyOnPressed,
    required Function() cookieOnPressed}) {
  return [
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextButton(
          onPressed: termsOnPressed,
          text: 'Terms & Conditions',
          fontSize: 12,
          color: Colors.black,
        ),
        bulletPoint(),
        CustomTextButton(
          onPressed: privacyOnPressed,
          text: 'Privacy Policy',
          fontSize: 12,
          color: Colors.black,
        ),
        bulletPoint(),
        CustomTextButton(
          onPressed: cookieOnPressed,
          text: 'Cookie Policy',
          fontSize: 12,
          color: Colors.black,
        ),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.copyright,
          size: 16,
          color: Colors.black,
        ),
        SizedBox(
          width: 2,
        ),
        Text(
          'Copyright 2023-2024 Jatya Inc.',
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
        ),
      ],
    )
  ];
}
