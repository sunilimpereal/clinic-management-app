import 'package:flutter/material.dart';
import 'package:clinic_app/modules/MyPrescription/screens/latest_prescription_tabs/prescription.dart';

class VitalsCard extends StatelessWidget {
  final String vitalName;
  final String vitalValue;
  final String vitalUnit;
  final Color backgroundColor;
  final VitalCondition vitalCondition;
  const VitalsCard(
      {super.key,
      required this.vitalName,
      required this.vitalValue,
      required this.vitalUnit,
      required this.vitalCondition,
      required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 366,
      // height: 89,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor,
          border: Border.all(color: Colors.black, width: 0.2)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  vitalName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      vitalValue,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: vitalCondition != VitalCondition.normal
                            ? Colors.red
                            : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        vitalUnit,
                        style: TextStyle(
                            color: Colors.grey.shade800, fontSize: 12),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Text(
                vitalCondition == VitalCondition.normal
                    ? "Normal"
                    : vitalCondition == VitalCondition.aboveNormal
                        ? "Above normal"
                        : "Below Normal",
                style: TextStyle(
                  fontSize: 12,
                  color: vitalCondition != VitalCondition.normal
                      ? Colors.red
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
