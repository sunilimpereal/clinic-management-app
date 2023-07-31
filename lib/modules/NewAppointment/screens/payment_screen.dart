import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'dart:developer';

import 'package:jatya_patient_mobile/common_components/widgets/error_alert_dialog.dart';
import 'package:jatya_patient_mobile/common_components/widgets/label.dart';
import 'package:jatya_patient_mobile/modules/NewAppointment/model/appointment/create_appointment.dart';
import 'package:jatya_patient_mobile/modules/NewAppointment/services/appointment_repository.dart';
import 'package:jatya_patient_mobile/modules/NewAppointment/widgets/recipt.dart';
import 'package:jatya_patient_mobile/utils/SharePref.dart';
import 'package:jatya_patient_mobile/utils/constants/image_konstants.dart';
import '../../../common_components/widgets/dotted_divider.dart';
import '../../../common_components/widgets/popup_widget.dart';
import '../../../utils/constants/color_konstants.dart';
import '../../online_consultation/widgets/doctor_card.dart';
import '../bloc/appointment_bloc.dart';
import '../model/appointment/get_slots_response.dart';
import '../model/doctors_via_location_response.dart';

class PaymentScreen extends StatefulWidget {
  final AvailableDoctor availableDoctor;
  final DoctorClinic clinic;
  final SlotDatum slot;
  final DateTime selectedDate;
  const PaymentScreen({
    super.key,
    required this.availableDoctor,
    required this.clinic,
    required this.slot,
    required this.selectedDate,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    log("Selected Date: ${widget.selectedDate}");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: ColorKonstants.greybgColor,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10, bottom: 10, right: 50),
                  child: Text(
                    'You are trying to book an appointment with',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700),
                  ),
                ),
                doctorDetial(),
                clinicDetail(),
                charges(),
              ],
            ),
          ),
          BlocBuilder<AppointmentBloc, AppointmentState>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width * 0.85,
                child: ElevatedButton(
                  onPressed: () async {
                    try {

                       var resp = await AppointmentRepository()
                          .bookAppointmnet(AppointmentRequest(
                        title:
                            "${sharedPrefs.name} ${widget.availableDoctor.userData.name} Appointment ${DateFormat("dd/MM/yyyy").format(widget.selectedDate.toLocal())}",
                        // title:
                        //     "Test Appointment ${DateFormat("dd/MM/yyyy").format(widget.selectedDate.add(const Duration(days: 1)).toUtc())}",
                        clinicId: widget.availableDoctor.doctor.clinicId,
                        patientId: sharedPrefs.patientId ?? '',
                        doctorId: widget.availableDoctor.doctor.id,
                        //doctorWorkingHoursId: widget.slot.id,
                        // appointmentDate: widget.selectedDate
                        //     .add(const Duration(days: 1))
                        //     .toUtc(),
                        appointmentDate: widget.selectedDate.toUtc(),
                        startTime: DateTime(
                                widget.selectedDate.year,
                                widget.selectedDate.month,
                                widget.selectedDate.day,
                                widget.slot.startTime.hour,
                                widget.slot.startTime.minute)
                            .toUtc(),
                        speciality:
                            widget.availableDoctor.specialisation.specialisation,
                        isEmergency: state.isEmergency,
                        priorityType: "REGULAR",
                        status: "PENDING",
                        paymentStatus: "PENDING",
                        endTime: DateTime(
                                widget.selectedDate.year,
                                widget.selectedDate.month,
                                widget.selectedDate.day,
                                widget.slot.endTime.hour,
                                widget.slot.endTime.minute)
                            .toUtc(),
                        appointmentType: "PENDING",
                      )).then((value) {
                          showPopup(
                              context: context,
                              child: Recipt(
                                availableDoctor: widget.availableDoctor,
                                createAppointmentResponse: value,
                              ));
                      });
                    } catch (e) {
                      showPopup(
                          context: context,
                          child: ErrorAlertDialog(error: e.toString()));
                    }
                  },
                  child: const Text("Proceed"),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget doctorDetial() {
    return Container(
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          ProfileImage(
            image: widget.availableDoctor.userData.photo ??
                ImagesConstants.networkImageProfilePicPlacholder,
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.availableDoctor.userData.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //const Stars(value: 5),
                  verifiedTag(context)
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  '${widget.availableDoctor.doctor.qualification} | ${widget.availableDoctor.doctor.description}',
                  maxLines: 1,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 12,
                      color:
                          ColorKonstants.subHeadingTextColor.withOpacity(0.6)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget clinicDetail() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          ProfileImage(image: widget.clinic.logo),
          const SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      widget.clinic.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Label(
                      label: Row(
                        children: [
                          Icon(
                            Icons.calendar_month_rounded,
                            size: 14,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 4),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Text(
                              "${DateFormat("EEE").format(widget.selectedDate)}, ${DateFormat("MMM").format(widget.selectedDate)} ${widget.selectedDate.day} | ${DateFormat("hh:mm").format(widget.slot.startTime)} -${DateFormat("hh:mm").format(widget.slot.endTime)} ",
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          const SizedBox(width: 4),
                        ],
                      ),
                      context: context)
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Text(
                  "Clinic ID ${widget.availableDoctor.doctor.clinicId} | ${widget.availableDoctor.userData.address} ",
                  style: TextStyle(
                      fontSize: 12,
                      color:
                          ColorKonstants.subHeadingTextColor.withOpacity(0.6)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget charges() {
    Widget chargeItem({required String title, required String amount}) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.grey),
            ),
            Text(
              amount,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              chargeItem(title: "Consultation charges", amount: "₹500.00 "),
              //chargeItem(title: "Serive charge", amount: "₹37.56 "),
              /*Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.discount_outlined),
                        LinkText(
                            onPressed: () {
                              showPopup(context: context, child: const DiscountPopup());
                            },
                            text: "Discount Applied"),
                      ],
                    ),
                    const Text(
                      "₹200.00",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),*/
              const DottedDivider(
                height: 0.5,
              ),
              chargeItem(title: "Amount payable", amount: "₹500.00"),
            ],
          )
        ],
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  final String image;
  final double scale;
  const ProfileImage({
    super.key,
    required this.image,
    this.scale = 0.15,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * scale,
      height: MediaQuery.of(context).size.width * scale,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Theme.of(context).primaryColor.withOpacity(0.2),
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
      ),
    );
  }
}

class Stars extends StatelessWidget {
  final int value;
  const Stars({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    int star = value > 5 ? 5 : value;
    List<Widget> starsList = [];
    for (int i = 0; i < star; i++) {
      starsList.add(const Padding(
        padding: EdgeInsets.all(0.0),
        child: Icon(
          size: 14,
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
          size: 14,
          color: Colors.grey.withOpacity(0.3),
        ),
      ));
    }
    // return Row(
    //   children: starsList,
    // );
    return Container();
  }
}
