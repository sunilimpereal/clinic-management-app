import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jatya_patient_mobile/common_components/widgets/link_text.dart';
import 'package:jatya_patient_mobile/modules/Mediline/bloc/get_doctors_bloc.dart';
import 'package:jatya_patient_mobile/modules/Mediline/widgets/share_with_clinic_card.dart';
import 'package:jatya_patient_mobile/modules/Mediline/widgets/share_with_doctor_card.dart';
import 'package:jatya_patient_mobile/modules/Mediline/widgets/single_mediline_card.dart';

import '../../../utils/helper/helper.dart';
import '../bloc/mediline_bloc.dart';
import '../models/get_appointmens_response.dart';

class ShareAppointmentPopup extends StatefulWidget {
  final List<AppointmentDatum> appointmentDetailList;
  final dynamic shareFunction;
  final dynamic revokeFunction;
  const ShareAppointmentPopup({
  super.key,
  required this.appointmentDetailList,
  required this.shareFunction,
  required this.revokeFunction,
  });

  @override
  State<ShareAppointmentPopup> createState() => _ShareAppointmentPopupState();
}

class _ShareAppointmentPopupState extends State<ShareAppointmentPopup> {
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
          medilineDetail(),
          appointmentList(),
        ],
      ),
    );
  }

  Widget medilineDetail() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.grey.shade200.withOpacity(0.5),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Share your mediline"),
              LinkText(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: "close"),
            ],
          ),
          // const SingleMedilineCard(),
          const SizedBox(
            height: 8,
          ),
          SingleMedilineCard(appointmentDetail: widget.appointmentDetailList[0])
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
                    shareFunction: () async {
                      return await widget.shareFunction(
                        doctorId: state.doctors[index].doctor.clinicId,
                      );
                    },
                    revokeFunction: () async {
                      return await widget.revokeFunction(
                        doctorId: state.doctors[index].doctor.clinicId,
                      );
                    },
                    appointmentDetailList: widget.appointmentDetailList,
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
}
