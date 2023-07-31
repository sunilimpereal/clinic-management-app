// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final Function() onPressed;
  final TextDecoration? decoration;
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  const CustomTextButton({
    this.decoration,
    this.color,
    Key? key,
    required this.onPressed,
    required this.text,
    required this.fontSize,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          text,
          style: TextStyle(
            decoration: decoration,
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
