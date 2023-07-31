import 'package:flutter/material.dart';
import 'package:clinic_app/modules/Profile/widgets/patient_circular_profile_pic.dart';
import 'package:clinic_app/utils/SharePref.dart';

import '../models/patient/get_patient_details_response.dart';

class PatientProfileHeader extends StatelessWidget {
  final PatientData patientData;
  const PatientProfileHeader({Key? key, required this.patientData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PatientCircularProfilePic(
            profilePhotoUrl: patientData.userPatientData.photo ?? ''),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                patientData.userPatientData.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Wrap(
                alignment: WrapAlignment.start,
                children: [
                  if (sharedPrefs.uhid != null && sharedPrefs.uhid!.isNotEmpty)
                    SizedBox(
                      // width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                        'UHID: ${sharedPrefs.uhid}',
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),
                    ),
                  if (sharedPrefs.uhid != null && sharedPrefs.uhid!.isNotEmpty)
                    const SizedBox(
                      width: 15,
                    ),
                  SizedBox(
                    child: Text(
                      'JATYA ID: ${sharedPrefs.jatyaId}',
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
