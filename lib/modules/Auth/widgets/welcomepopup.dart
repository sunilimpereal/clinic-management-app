import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:clinic_app/modules/Auth/model/login/login_response_model.dart';
import 'package:clinic_app/modules/Profile/bloc/update_patient_bloc/updatepatient_bloc.dart';

import 'package:clinic_app/modules/Profile/screens/patient_profile_screen.dart';
import 'package:clinic_app/modules/Profile/screens/patient_update_profile.dart';
import 'package:clinic_app/modules/Profile/widgets/patient_circular_profile_pic.dart';
import 'package:clinic_app/utils/constants/color_konstants.dart';
import 'package:clinic_app/utils/constants/image_konstants.dart';

import '../../Profile/models/patient/get_patient_details_response.dart';
import '../../Profile/services/patient_repositroy.dart';

class Welcomepopup extends StatefulWidget {
  const Welcomepopup({super.key, this.response});
  final LoginResponseModel? response;
  @override
  State<Welcomepopup> createState() => _WelcomepopupState();
}

class _WelcomepopupState extends State<Welcomepopup> {
  final _confettiController = ConfettiController();
  int _start = 5;
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        setState(() {
          if (_start == 0) {
            timer.cancel();
            _confettiController.stop();
          } else {
            _start--;
          }
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _confettiController.play();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = TextStyle(color: ColorKonstants.labelTextColor);
    return Center(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 54.0),
            margin: const EdgeInsets.only(top: 36.0, bottom: 45),
            child: Material(
              borderRadius: BorderRadius.circular(8),
              clipBehavior: Clip.hardEdge,
              color: Colors.white,
              child: SizedBox(
                height: MediaQuery.of(context).size.height > 667
                    ? MediaQuery.of(context).size.height * 0.65
                    : MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.grey.shade100,
                      child: Column(
                        children: [
                          const SizedBox(height: 45),
                          Text(
                            widget.response?.data.user.name ?? "",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8.0),
                          // Padding(
                          //   padding: const EdgeInsets.only(right: 10),
                          //   child: CircleAvatar(
                          //     radius: 18, // set the radius of the circle
                          //     backgroundImage: AssetImage(
                          //         'assets/images/image.png'), // set the image path
                          //   ),
                          // ), CODE TO ADD CIRCULAR IMAGE LATER WHEN ASSET IS PROVIDED.
                          Padding(
                            padding: const EdgeInsets.only(left: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Column(
                                    children: [
                                      if (widget.response?.data.user.patient
                                              .uhid !=
                                          null)
                                        SizedBox(
                                          // width: 150,
                                          child: Text(
                                            "UHID : ${widget.response?.data.user.patient.uhid}",
                                            overflow: TextOverflow.ellipsis,
                                            style: labelStyle,
                                          ),
                                        ),
                                      Text(
                                          "JATYA ID: ${widget.response?.data.user.jatyaId}",
                                          style: labelStyle),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                // Text(
                                //   '\u2022 ',
                                //   style: TextStyle(
                                //     fontSize: 26,
                                //     color: ColorKonstants.labelTextColor,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    widget.response?.data.user.phoneNumber ??
                                        "",
                                    style: labelStyle),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text('\u2022 ',
                                    style: labelStyle.copyWith(fontSize: 26)),
                                Text(
                                  widget.response?.data.user.email ??
                                      " Ehsaan@gmail.com",
                                  style: labelStyle,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: [
                        welcomeDetails(
                          label1: 'Demographics',
                          label2: 'Not Provided',
                        ),
                        const SizedBox(height: 6),
                        const Divider(),
                        const SizedBox(height: 6),
                        welcomeDetails(
                            label1: 'Allergy Information',
                            label2: 'Not Provided'),
                        const SizedBox(height: 6),
                        const Divider(),
                        const SizedBox(height: 6),
                        welcomeDetails(
                            label1: 'Vaccination', label2: 'Not Provided'),
                        const SizedBox(height: 6),
                        const Divider(),
                        const SizedBox(height: 6),
                        welcomeDetails(
                            label1: 'Previous Reports', label2: 'Not Provided'),
                        const SizedBox(height: 6),
                        const Divider(),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            ImagesConstants.userProfileIcon,
                            width: 60,
                          ),
                          const SizedBox(width: 20.0),
                          const Expanded(
                            child: Text(
                              "Keeping your profile updated helps secure faster appointment bookings and less wait times at the clinic.",
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Need to add image here the asset is missing.
                    const SizedBox(height: 24),
                    FutureBuilder<GetPatientResponse?>(
                        future: PatientRepository().getpatientDetails(),
                        builder: (context, snapshot) {
                          return SizedBox(
                            width: 270,
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PatientProfileScreen()));
                                context.read<UpdatePatientBloc>().add(
                                    UpdatePatientInitialFillEvent(
                                        patientData: snapshot.data!.data));

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PatientUpdateDetails(
                                      patientData: snapshot.data!.data,
                                    ),
                                  ),
                                );
                              },
                              child: const Text("Update My Profile"),
                            ),
                          );

                          // return Container();
                        }),
                    const SizedBox(height: 4),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Not now",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            width: MediaQuery.of(context).size.width * 0.9,
            child: const Center(
              child: Text(
                'WELCOME',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: MediaQuery.of(context).size.width * 0.5,
            child: ConfettiWidget(
              confettiController: _confettiController,
              shouldLoop: true,
              blastDirectionality: BlastDirectionality.explosive,
            ),
          ),
          Positioned(
            top: 60,
            left: MediaQuery.of(context).size.width * 0.38,
            child: CircleAvatar(
              radius: 30,
              child: ClipOval(
                child: Material(
                  child: PatientCircularProfilePic(
                    profilePhotoUrl: widget.response?.data.user.photo ?? '',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding welcomeDetails({required String label1, required String label2}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label1,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            label2,
            style: const TextStyle(color: Colors.blue),
          ),
        ],
      ),
    );
  }
}



// REMARKS:- ASSETS ARE MISSING AND IMAGE IS MISSING