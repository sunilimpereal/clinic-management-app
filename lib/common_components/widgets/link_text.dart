import 'package:flutter/material.dart';

class LinkText extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Function() onPressed;
  const LinkText({
    super.key,
    required this.onPressed,
    this.textColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: textColor ?? Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
