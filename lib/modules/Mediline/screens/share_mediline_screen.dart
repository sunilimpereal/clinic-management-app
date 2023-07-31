import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic_app/common_components/widgets/link_text.dart';
import 'package:clinic_app/modules/Mediline/bloc/get_doctors_bloc.dart';
import 'package:clinic_app/modules/Mediline/widgets/share_with_clinic_card.dart';
import 'package:clinic_app/modules/Mediline/widgets/share_with_doctor_card.dart';
import 'package:clinic_app/modules/Mediline/widgets/single_mediline_card.dart';

import '../../../utils/helper/helper.dart';
import '../bloc/mediline_bloc.dart';
import '../models/get_appointmens_response.dart';

class ShareMedilinePopup extends StatefulWidget {
  final List<AppointmentDatum> appointmentDetailList;
  final dynamic shareFunction;
  final dynamic revokeFunction;
  const ShareMedilinePopup({
    super.key,
    required this.appointmentDetailList,
    required this.shareFunction,
    required this.revokeFunction,
  });

  @override
  State<ShareMedilinePopup> createState() => _ShareMedilinePopupState();
}

class _ShareMedilinePopupState extends State<ShareMedilinePopup> {
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

  Widget clinicList() {
    return Expanded(
      child: SingleChildScrollView(
        child: BlocBuilder<MedilineBloc, MedilineState>(
          builder: (context, state) {
            if (state is MedilineErrorState) {
              const Center(
                child: Text("Something Went Wrong!"),
              );
            }
            if (state is MedilineLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is MedilineSuccessState) {
              return Column(
                children: state.clinicList
                    ?.map((element) => ShareWithClinicCard(
                  // Share appointment
                  clinic: element,
                  revokeFunction: () async {
                    return await widget.revokeFunction(
                      clinicId: element.id,
                    );
                  },
                  shareFunction: () async {
                    return await widget.shareFunction(
                      clinicId: element.id,
                    );
                  },
                  appointmentDetailList:
                  widget.appointmentDetailList,
                ))
                    .toList() ??
                    [],
              );
            }
            return const Center(
              child: Text("Something Went Wrong!"),
            );
          },
        ),
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
                        doctorId: state.doctors[index].doctor.userId,
                      );
                    },
                    revokeFunction: () async {
                      return await widget.revokeFunction(
                        doctorId: state.doctors[index].doctor.userId,
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
