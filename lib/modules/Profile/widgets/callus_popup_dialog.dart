import 'package:flutter/material.dart';

import '../../../utils/constants/color_konstants.dart';

class ProfilePopupDialog extends StatelessWidget {
  final String? image;
  final Widget child;
  final double height;
  final bool side;
  final Icon? icon;
  final Color backColor;
  final Color? iconBackColor;

  const ProfilePopupDialog({
    Key? key,
    this.image,
    this.icon,
    this.iconBackColor,
    required this.child,
    required this.backColor,
    required this.height,
    required this.side,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 60,
            left: 30,
            right: 30,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              borderRadius: BorderRadius.circular(8),
              elevation: 10,
              child: Container(
                  padding: const EdgeInsets.only(
                    top: 48,
                    left: 16,
                    right: 16,
                    bottom: 16,
                  ),
                  color: backColor,
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: height,
                  child: child),
            ),
          ),
        ),
        Positioned(
          top: side ? 30 : 35,
          left: side
              ? MediaQuery.of(context).size.width / 7
              : MediaQuery.of(context).size.width / 2.5,
          child: Material(
            borderRadius: BorderRadius.circular(100),
            color: backColor,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width: side ? 55 : 44,
                height: side ? 55 : 44,
                decoration: BoxDecoration(
                  color: iconBackColor ?? ColorKonstants.blueccolor,
                  borderRadius: BorderRadius.circular(100),
                ),
                padding: const EdgeInsets.all(0),
                child: !side
                    ? Center(
                        child: icon!,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Center(
                          child: Image(
                            image: AssetImage(image!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
