import 'package:flutter/material.dart';
import 'package:clinic_app/utils/constants/image_konstants.dart';

class QRPlaceholder extends StatelessWidget {
  const QRPlaceholder({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.width * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        border: Border.all(
          color: Colors.black26, // Set the border color here
          width: 1, // Set the border width here
        ),
        image: const DecorationImage(
          image: AssetImage(ImagesConstants.qrPlaceholder),
        ),
      ),
    );
  }
}
