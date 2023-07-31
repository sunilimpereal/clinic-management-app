// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:clinic_app/modules/MyPrescription/models/latest_prescription.dart';
import 'package:clinic_app/utils/SharePref.dart';
import 'package:clinic_app/utils/constants/image_konstants.dart';

class ClinicListItem extends StatelessWidget {
  final GetAllPrescriptionData clinicModel;
  const ClinicListItem({
    Key? key,
    required this.clinicModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String patientpic = sharedPrefs.getProfilePic;
    log(clinicModel.name!);
    var dateString = DateFormat('dd MMM yyyy').format(
        DateTime.parse(clinicModel.createdDate ?? "2021-09-09T12:00:00.000Z"));
    return ListTile(
      leading: SizedBox(
        width: 80,
        height: 40,
        child: Stack(children: [
          const Positioned(
            left: 27.5,
            child: CircleAvatar(
              radius: 20.0,
              backgroundImage: AssetImage(ImagesConstants.clinicPlaceholder),
            ),
          ),
          Positioned(
            left: 5.0,
            child: CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(patientpic),
            ),
          ),
        ]),
      ),
      title: Text(
        clinicModel.name ?? "prescription name",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(dateString),
    );
  }
}
