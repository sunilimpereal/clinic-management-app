import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jatya_patient_mobile/modules/Mediline/models/get_appointmens_response.dart';

import '../bloc/mediline_bloc.dart';
import 'mediline_card.dart';

class ClinicAppointmentsTabView extends StatefulWidget {
  final List<AppointmentDatum> appointments;
  const ClinicAppointmentsTabView({super.key, required this.appointments});

  @override
  State<ClinicAppointmentsTabView> createState() => _ClinicAppointmentsTabViewState();
}

class _ClinicAppointmentsTabViewState extends State<ClinicAppointmentsTabView> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset == _scrollController.position.maxScrollExtent) {
        log("load more");
        context.read<MedilineBloc>().add(const MedilineGetAppointmetnsLoadMore());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<AppointmentDatum> upcoming = widget.appointments
        .where((element) => element.appointment.appointmentDate.compareTo(DateTime.now()) > 0 && element.appointment.status != "CANCELLED")
        .toList();
    List<AppointmentDatum> today = widget.appointments
        .where((element) => element.appointment.appointmentDate.difference(DateTime.now()).inDays == 0 && element.appointment.status != "CANCELLED")
        .toList();
    List<AppointmentDatum> yearWise = widget.appointments.where((element) => element.appointment.status != "CANCELLED").toList();

    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          upcoming.isEmpty && today.isEmpty && yearWise.isEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: const Center(child: Text('No Appointment Found')))
              : Column(children: [
                  upcoming.isNotEmpty
                      ? appointmentsList(
                          title: "Upcoming",
                          appointments: upcoming
                              .map((eUp) => MedilineCard(
                                    appointmentDetail: eUp,
                                    isUpcoming: true,
                                  ))
                              .toList())
                      : Container(),
                  today.isNotEmpty
                      ? appointmentsList(
                          title: "Today ${DateFormat.yMMMd().format(DateTime.now())}",
                          appointments: today.map((eToday) => MedilineCard(appointmentDetail: eToday)).toList())
                      : Container(),
                  ...yearWiseAppointemnts(yearWise)
                ]),
        ],
      ),
    );
  }

  List<Widget> yearWiseAppointemnts(List<AppointmentDatum> appointements) {
    List<int> years = appointements.map((e) => e.appointment.appointmentDate.year).toSet().toList();
    List<Widget> list = [];
    for (int year in years) {
      List<AppointmentDatum> yearList = [];
      for (AppointmentDatum appointmentDetail in appointements) {
        if (appointmentDetail.appointment.appointmentDate.year == year) {
          yearList.add(appointmentDetail);
        }
      }
      list.add(appointmentsList(title: year.toString(), appointments: yearList.map((e) => MedilineCard(appointmentDetail: e)).toList()));
    }
    return list;
  }

  Widget appointmentsList({
    required String title,
    required List<Widget> appointments,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 18.0),
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: appointments.map((e) => e).toList(),
          )
        ],
      ),
    );
  }
}
