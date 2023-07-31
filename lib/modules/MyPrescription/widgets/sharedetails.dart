import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jatya_patient_mobile/common_components/widgets/link_text.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/bloc/get_all_doctors_bloc.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/models/latest_prescription.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/models/share_prescription_request_model.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/services/prescription_services.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/widgets/doctor_card.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/widgets/prescription_card.dart';

import 'package:jatya_patient_mobile/utils/SharePref.dart';
import 'package:jatya_patient_mobile/utils/helper/helper.dart';

import '../../../utils/constants/color_konstants.dart';
import '../models/revoke_prescription_request_model.dart';

class PrescriptionShareDetails extends StatefulWidget {
  final GetAllPrescriptionData prescriptionData;
  final String? topHeading;
  const PrescriptionShareDetails({
    this.topHeading,
    required this.prescriptionData,
    super.key,
  });

  @override
  State<PrescriptionShareDetails> createState() => _PrescriptionShareDetailsState();
}

class _PrescriptionShareDetailsState extends State<PrescriptionShareDetails> {
  @override
  void initState() {
    BlocProvider.of<GetAllDoctorsBloc>(context).add(GetAllDoctorsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          doctorDetail(),
          appointmentList(),
        ],
      ),
    );
  }

  Widget doctorDetail() {
    DateTime date = DateTime.parse(widget.prescriptionData.createdDate??'');
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.grey.shade200.withOpacity(0.5),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.topHeading ?? "Share your report",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black54),
                ),
              ),
              LinkText(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: "close",
                textColor: ColorKonstants.linkColor,
              ),
            ],
          ),
          // const SingleMedilineCard(),
          const SizedBox(
            height: 8,
          ),
          PrescriptionDetailCard(
            date: date,
            title: widget.prescriptionData.name ?? '',
            description: widget.prescriptionData.id ?? '',
          ),
        ],
      ),
    );
  }

  Widget appointmentList() {
    return BlocBuilder<GetAllDoctorsBloc, GetAllDoctorsState>(
      builder: (context, state) {
        log(state.toString());
        if (state is GetAllDoctorsLoadingState) {
          return const SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is GetAllDoctorsSuccessState) {
          return Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return DoctorCard(
                    doctor: state.doctors[index],
                    prescriptionId: widget.prescriptionData.id?? '',
                    shareFunction: () async {
                      bool res = false;
                      await PrescriptionRepo()
                          .sharePrescriptionToDoctor(requestBody: [
                        SharePrescriptionRequestModel(
                            prescriptionId: widget.prescriptionData.id??'',
                            sharedById: sharedPrefs.id ?? "",
                            sharedToId: state.doctors[index].doctor.userId)
                      ]).then((value) {
                        res = true;
                      }).catchError((e) {
                        WidgetHelper.showToast(e.toString());
                      });
                      return res;
                    }, revokeFunction: () async {
                    bool res = true;
                    await PrescriptionRepo().revokeSharePrescriptionToDoctor(
                      request: RevokePrescriptionSharingRequest(
                        prescriptionId: widget.prescriptionData.id ?? '',
                        sharedById: sharedPrefs.id ?? "",
                        sharedToId: state.doctors[index].doctor.userId,
                      ),
                    )
                        .then((value) {
                      res = false;
                    }).catchError((e) {
                      WidgetHelper.showToast(e.toString());
                    });
                    return res;
                  },
                  );
                },
                itemCount: state.doctors.length),
          );
        }

        if (state is GetAllDoctorsErrorState) {
          return const SizedBox(
            width: 500,
            height: 500,
            child: Text("No doctors Available"),
          );
        }
        return Container();
      },
    );
  }

  Widget starsWidget({required int value}) {
    int star = value > 5 ? 5 : value;
    List<Widget> starsList = [];
    for (int i = 0; i < star; i++) {
      starsList.add(const Padding(
        padding: EdgeInsets.all(0.0),
        child: Icon(
          size: 18,
          Icons.star_rounded,
          color: Colors.amber,
        ),
      ));
    }
    for (int i = 0; i < 5 - star; i++) {
      starsList.add(Padding(
        padding: const EdgeInsets.all(0.0),
        child: Icon(
          Icons.star_rounded,
          size: 18,
          color: Colors.grey.withOpacity(0.3),
        ),
      ));
    }
    return Row(
      children: starsList,
    );
  }
}

Widget verifiedTag(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(right: 5),
    child: Container(
      decoration: BoxDecoration(
        color: ColorKonstants.primarySwatch.shade100,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(
            width: 0.5, color: ColorKonstants.verifiedBorder.withOpacity(0.7)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_rounded,
            size: 20,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 4),
          Text(
            'VERIFIED',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
          const SizedBox(width: 4),
        ],
      ),
    ),
  );
}
