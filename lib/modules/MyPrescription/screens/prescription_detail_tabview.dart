import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:clinic_app/modules/MyPrescription/bloc/get_all_doctors_bloc.dart';
import 'package:clinic_app/modules/MyPrescription/bloc/prescription_deatils/prescription_details_bloc.dart';
import 'package:clinic_app/modules/MyPrescription/models/latest_prescription.dart';
import 'package:clinic_app/modules/MyPrescription/models/prescription_deatils/prescription_details.dart';
import 'package:clinic_app/modules/MyPrescription/screens/latest_prescription_tabs/about_the_clinic.dart';
import 'package:clinic_app/modules/MyPrescription/screens/latest_prescription_tabs/doctors_profile.dart';
import 'package:clinic_app/modules/MyPrescription/screens/latest_prescription_tabs/prescription.dart';
import 'package:clinic_app/modules/MyPrescription/widgets/sharedetails.dart';
import 'package:clinic_app/utils/constants/color_konstants.dart';
import 'package:clinic_app/utils/constants/image_konstants.dart';

import '../../../common_components/widgets/popup_widget.dart';
import '../../../common_components/widgets/sharing_consent_dialog.dart';
import '../../../utils/constants/terms_konstants.dart';
import 'latest_prescription_tabs/report.dart';

class PrescriptionDetailTabview extends StatefulWidget {
  PrescriptionDetailTabview({super.key, required this.getAllPrescriptionData});
  GetAllPrescriptionData getAllPrescriptionData;

  @override
  State<PrescriptionDetailTabview> createState() =>
      _PrescriptionDetailTabviewState();
}

class _PrescriptionDetailTabviewState extends State<PrescriptionDetailTabview> {
  final PrescriptionDetailsBlocBloc _getPrescriptionDetailsBloc =
      PrescriptionDetailsBlocBloc();

  static bool isDetailedView = false;
  String pdfUrl = "";

  @override
  void initState() {
    _getPrescriptionDetailsBloc.add(GetPrescriptionDetailsEvent(
      appointmentID: widget.getAllPrescriptionData.appointmentId!,
    ));
    // _getPrescriptionDetailsBloc.add(DownloadPrescriptionDetailsEvent(
    //     prescriptionId: widget.getAllPrescriptionData.id!));
    // log("pdfurl is here");

    // // Retrieve data from the first emitted success state
    // _getPrescriptionDetailsBloc.stream
    //     .firstWhere((state) => state is PrescriptionDownloadBlocSuccess)
    //     .then((state) {
    //   if (state is PrescriptionDownloadBlocSuccess) {
    //     log("pdfurl is${state.prescriptionPdfurl} ");

    //     pdfUrl = state.prescriptionPdfurl;
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    _getPrescriptionDetailsBloc.close();
    super.dispose();
  }

  // Future<void> _launchURL(String url) async {
  //   log(url);
  //   final Uri uri = Uri.parse(url);
  //   try {
  //     if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
  //       log("yes launched");
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double widthOfdevice = MediaQuery.of(context).size.width;
    var createdAt = widget.getAllPrescriptionData.createdDate;
    var dateString = '';
    dateString = DateFormat("dd MMMM yyyy ").format(DateTime.parse(createdAt!));
    return SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AppBar(
                    // backgroundColor: ColorKonstants.primarySwatch,
                    actions: [
                      popUpMenuButton(context),
                    ],
                  ),
                  Positioned(
                    left: widthOfdevice * 0.200,
                    child: const CircleAvatar(
                      radius: 20.0,
                      backgroundImage:
                          AssetImage(ImagesConstants.clinicPlaceholder),
                    ),
                  ),
                  Positioned(
                    left: widthOfdevice * 0.145,
                    child: const CircleAvatar(
                      radius: 20.0,
                      backgroundImage:
                          AssetImage(ImagesConstants.circleavatar2),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: widthOfdevice * 0.310,
                    child: const Text(
                      "Visit types goes here",
                      style: TextStyle(fontSize: 19, color: Colors.white),
                    ),
                  ),
                  Positioned(
                      top: 35,
                      left: widthOfdevice * 0.310,
                      child: Text(
                        dateString,
                        style: const TextStyle(
                            fontSize: 12, color: Colors.white60),
                      )),
                ],
              ),
            ),
            body: BlocListener<PrescriptionDetailsBlocBloc,
                    PrescriptionDetailsBlocState>(
                bloc: _getPrescriptionDetailsBloc,
                listenWhen: (previous, current) =>
                    current is PrescriptionDetailsActionBlocState,
                listener: (context, state) {
                  if (state is PrescriptionDownloadBlocLoading) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(microseconds: 200),
                        backgroundColor: ColorKonstants.primarySwatch,
                        content: Column(
                          children: const [
                            LinearProgressIndicator(),
                            SizedBox(height: 5),
                            Text('Downloading prescription...'),
                          ],
                        ),
                      ),
                    );
                  } else if (state is PrescriptionDownlaodBlocFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: ColorKonstants.primarySwatch,
                        content: Text('Prescription Url not found'),
                      ),
                    );
                  } else if (state is PrescriptionDownloadBlocSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: ColorKonstants.primarySwatch,
                        content: Text('Download Completed!!'),
                      ),
                    );
                  }
                },
                child: BlocBuilder<PrescriptionDetailsBlocBloc,
                    PrescriptionDetailsBlocState>(
                  bloc: _getPrescriptionDetailsBloc,
                  buildWhen: (previous, current) =>
                      current is! PrescriptionDetailsActionBlocState,
                  builder: (context, state) {
                    if (state is PrescriptionDetailsBlocLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is PrescriptionDetailsBlocSuccess) {
                      return body(context, state.prescriptionDetails);
                    } else if (state is PrescriptionDetailsBlocFailure) {
                      return body(context, null);
                    } else {
                      return const Center(child: Text("Something went wrong"));
                    }
                  },
                ))));

    // body(context, getAllPrescriptionData)));
  }

  Widget body(BuildContext context, PrescriptionDetails? prescriptionDetails) {
    return Column(
      children: [
        Expanded(
          child: DefaultTabController(
            length: 4,
            child: Column(
              children: [
                const TabBar(
                  isScrollable: true, // Make the tab bar scrollable
                  tabs: [
                    Tab(
                      text: 'Prescription',
                    ),
                    Tab(text: 'Reports'),
                    Tab(text: "Doctor's Profile"),
                    Tab(text: 'About the Clinic'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Prescription(
                        getAllPrescriptionData: widget.getAllPrescriptionData,
                        isdetailedView: isDetailedView,
                        doctorDetails: prescriptionDetails?.data?.doctor,
                      ),
                      Reports(
                        fileUrl: widget.getAllPrescriptionData.reportUrl ?? "",
                        getAllPrescriptionData: widget.getAllPrescriptionData,
                      ),
                      DoctorsProfile(
                        doctorDetails: prescriptionDetails?.data?.doctor,
                      ),
                      AbouttheClinicScreen(
                        clinicInformation: prescriptionDetails?.data?.clinic,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget popUpMenuButton(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: 'item1',
            child: ListTile(
              selected: true,
              onTap: () {
                setState(() {
                  isDetailedView = false;
                });
                Navigator.pop(context);
              },
              leading: const Padding(
                padding: EdgeInsets.only(right: 18.0),
                child:
                    Icon(Icons.menu_sharp, color: ColorKonstants.primarySwatch),
              ),
              title: Text(
                'Summary View',
                style: TextStyle(
                  color: !isDetailedView ? Colors.black26 : Colors.black,
                ),
              ),
            ),
          ),
          PopupMenuItem(
            value: 'item2',
            child: ListTile(
              selected: true,
              onTap: () {
                //Remark: Ui is Added for Detailed View uncomment
                //below Line for getting that Adding DefaultToastMsg
                setState(() {
                  isDetailedView = true;
                });
                Navigator.pop(context);
              },
              leading: const Padding(
                padding: EdgeInsets.only(right: 18.0),
                child: Icon(Icons.credit_card,
                    color: ColorKonstants.primarySwatch),
              ),
              title: Text(
                'Detailed View',
                style: TextStyle(
                  color: isDetailedView ? Colors.black26 : Colors.black,
                ),
              ),
            ),
          ),
          PopupMenuItem(
            value: 'item3',
            child: ListTile(
              selected: true,
              onTap: () {
                SharingConsentDialog.showWarningDialog(
                  context,
                  TermsConstants.sharePrescriptionConsent,
                  () {
                    Navigator.pop(context);
                    showPopup(
                      context: context,
                      child: BlocProvider<GetAllDoctorsBloc>(
                        create: (context) => GetAllDoctorsBloc(),
                        child: PrescriptionShareDetails(
                          prescriptionData: widget.getAllPrescriptionData,
                          topHeading: 'Share your prescription details',
                        ),
                      ),
                    );
                  },
                );
              },
              leading: Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: SvgPicture.asset(
                  ImagesConstants.shareDrawer,
                ),
              ),
              title: const Text(
                'Share Details with…',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          PopupMenuItem(
            value: 'item4',
            child: ListTile(
              selected: true,
              onTap: () {
                _getPrescriptionDetailsBloc.add(
                    DownloadPrescriptionDetailsEvent(
                        reportUrl: widget.getAllPrescriptionData.reportUrl));
                Navigator.pop(context);
              },
              leading: const Padding(
                padding: EdgeInsets.only(right: 18.0),
                child: Icon(Icons.file_download,
                    color: ColorKonstants.primarySwatch),
              ),
              title: const Text(
                'Download Prescription',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ];
      },
    );
  }
}
