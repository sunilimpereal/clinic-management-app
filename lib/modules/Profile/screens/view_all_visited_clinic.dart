import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../utils/constants/color_konstants.dart';
import '../../../utils/helper/map_utils.dart';
import '../models/patient/get_patinet_clinics_visited.dart';

class ViewAllVisitedClinic extends StatefulWidget {
  List<PatientClinicsVisit> allClinics;
  ViewAllVisitedClinic({super.key, required this.allClinics});

  @override
  State<ViewAllVisitedClinic> createState() => _ViewAllVisitedClinicState();
}

class _ViewAllVisitedClinicState extends State<ViewAllVisitedClinic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visited Clinics'),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          padding:const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          itemCount: widget.allClinics.length,
          itemBuilder: (context, index) {
            return clinicDetails(widget.allClinics[index], context);
          }),
    );
  }
}

Widget clinicDetails(PatientClinicsVisit clinic, BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(clinic.logo),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    clinic.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        clinic.id,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: ColorKonstants.headingTextColor,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Center(
                        child: Text('\u2022', style: TextStyle(fontSize: 24, color: Colors.grey)),
                      ),
                      const SizedBox(width: 5),
                      clinic.specialities.isEmpty
                          ? const Text("")
                          : SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Row(
                                children: [
                                  for (var item in clinic.specialities)
                                    Text(
                                      " ${item.speciality}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: ColorKonstants.headingTextColor,
                                        height: 1.2,
                                      ),
                                    )
                                ],
                              ),
                          )
                    ],
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.13),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                clinic.mobileNumbers.isEmpty
                    ? const Text("")
                    : Row(
                        children: [
                          for (var item in clinic.mobileNumbers)
                            Expanded(
                              child: GestureDetector(
                                  onTap: ()=>launchUrlString('tel:$item'),
                                  child: patientDemographicItem(CupertinoIcons.phone, item),
                            ),),
                        ],
                      ),
                InkWell(
                  onTap: ()=>launchUrlString('mailto:${clinic.emailId}'),
                    child: patientDemographicItem(CupertinoIcons.mail, clinic.emailId)),

                InkWell(
                  onTap: ()=>MapUtils.openMap("${clinic.address}-${clinic.zipCode}"),
                    child: patientDemographicItem(CupertinoIcons.location_solid,
                    "${clinic.address}-${clinic.zipCode}")),
              ],
            ),
          ),
        ]),
      ),
      const Divider(
        height: 1,
        thickness: 0.5,
        color: Colors.grey,
      ),
    ],
  );
}

Widget patientDemographicItem(IconData? icon, String title) {
  return Row(
    children: [
      Icon(
        icon,
        color: Colors.grey,
        size: 18,
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Text(title,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
              height: 1.5,
            )),
      ),
    ],
  );
}
