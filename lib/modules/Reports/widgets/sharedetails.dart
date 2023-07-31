import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jatya_patient_mobile/common_components/widgets/link_text.dart';
import 'package:jatya_patient_mobile/modules/Reports/bloc/get_all_doctors_bloc.dart';
import 'package:jatya_patient_mobile/modules/Reports/models/get_recent_report_response_model.dart';
import 'package:jatya_patient_mobile/modules/Reports/models/revoke_report_request_model.dart';
import 'package:jatya_patient_mobile/modules/Reports/models/share_report_request_model.dart';
import 'package:jatya_patient_mobile/modules/Reports/services/recent_reports_repo.dart';
import 'package:jatya_patient_mobile/modules/Reports/widgets/doctor_card.dart';
import 'package:jatya_patient_mobile/modules/Reports/widgets/report_card.dart';
import 'package:jatya_patient_mobile/utils/SharePref.dart';
import 'package:jatya_patient_mobile/utils/helper/helper.dart';

import '../../../utils/constants/color_konstants.dart';

class ShareDetails extends StatefulWidget {
  final GetRecentReportsData reportsData;
  final String? topHeading;
  const ShareDetails({
    this.topHeading,
    required this.reportsData,
    super.key,
  });

  @override
  State<ShareDetails> createState() => _ShareDetailsState();
}

class _ShareDetailsState extends State<ShareDetails> {
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
    DateTime date = DateTime.parse(widget.reportsData.reportDate ?? '');
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
          ReportDetailCard(
            date: date,
            title: widget.reportsData.reportName ?? '',
            description: widget.reportsData.id ?? '',
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
                    reportId: widget.reportsData.id ?? '',
                    shareFunction: () async {
                      bool res = false;
                      await RecentReportsRepository()
                          .shareReportToDoctor(requestBody: [
                        ShareReportRequestModel(
                          patientReportId: widget.reportsData.id ?? '',
                          reportSharedById: sharedPrefs.id ?? "",
                          reportSharedToId: state.doctors[index].doctor.userId,
                        )
                      ]).then((value) {
                        res = true;
                      }).catchError((e) {
                        WidgetHelper.showToast(e.toString());
                      });
                      return res;
                    },
                    revokeFunction: () async {
                      bool res = true;
                      await RecentReportsRepository()
                          .revokeShareReportToDoctor(
                        request: RevokeSharingRequest(
                          patientReportId: widget.reportsData.id ?? '',
                          reportSharedById: sharedPrefs.id ?? "",
                          reportSharedToId: state.doctors[index].doctor.userId,
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
