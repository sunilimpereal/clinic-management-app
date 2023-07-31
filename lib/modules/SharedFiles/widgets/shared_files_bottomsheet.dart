// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:clinic_app/common_components/services/file_download_handler.dart';
import 'dart:ui';
import 'package:clinic_app/common_components/widgets/app_alert_dialog.dart';
import 'package:clinic_app/modules/Mediline/models/revoke_appointment_request.dart';
import 'package:clinic_app/modules/Mediline/screens/my_mediline_screen.dart';
import 'package:clinic_app/modules/Mediline/services/mediline_repository.dart';
import 'package:clinic_app/modules/Mediline/widgets/mediline_card.dart';
import 'package:clinic_app/modules/MyPrescription/models/latest_prescription.dart';
import 'package:clinic_app/modules/MyPrescription/models/revoke_prescription_request_model.dart';
import 'package:clinic_app/modules/MyPrescription/screens/prescription_detail_tabview.dart';
import 'package:clinic_app/modules/MyPrescription/services/prescription_services.dart';
import 'package:clinic_app/modules/Reports/models/get_recent_report_response_model.dart';
import 'package:clinic_app/modules/Reports/models/revoke_report_request_model.dart';
import 'package:clinic_app/modules/Reports/screens/latest_reports_tabs/report.dart';
import 'package:clinic_app/modules/Reports/services/recent_reports_repo.dart';
import 'package:clinic_app/modules/SharedFiles/models/sharedfiles_model.dart';
import 'package:clinic_app/modules/SharedFiles/services/sharedfiles_repo.dart';
import 'package:clinic_app/utils/SharePref.dart';
import 'package:clinic_app/utils/constants/color_konstants.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareFilesBottomSheet extends StatelessWidget {
  final SharedFileData sharedFile;
  final Function refresh;
  const ShareFilesBottomSheet({
    super.key,
    required this.sharedFile,
    required this.refresh,
  });

  void showToast(String msg) => Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );

  void _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.28,
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          fileInfo(),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SheetIconButton(
                icon: Icons.plagiarism_rounded,
                onPressed: () => showDetails(context),
                text: "View Details",
              ),
              sharedFile.sharedRecord == SharedRecod.ShareAppointment ||
                      sharedFile.sharedRecord == SharedRecod.ShareMediline ||
                      sharedFile.sharedRecord == SharedRecod.other
                  ? const SizedBox()
                  : SheetIconButton(
                      icon: Icons.download,
                      onPressed: () {
                        if (sharedFile.sharedRecord ==
                            SharedRecod.ShareReport) {
                          downloadReport();
                        } else if (sharedFile.sharedRecord ==
                            SharedRecod.SharedPrescription) {
                          downloadPrescription();
                        } else if (sharedFile.sharedRecord ==
                            SharedRecod.ShareAppointment) {
                          downloadAppointment();
                        } else {
                          downloadMediline();
                        }
                        Navigator.pop(context);
                      },
                      text: "Download",
                    ),
              SheetIconButton(
                icon: Icons.delete,
                onPressed: () {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (context) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: AppAlertDialog(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.white,
                            ),
                            iconColor: ColorKonstants.errorColor,
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: Column(
                              children: [
                                const Text(
                                  'By removing the sharing, Doctor will not be able to access this file anymore. Are you sure you want to continue?',
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .65,
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            width: 1, color: Colors.red)),
                                    onPressed: () {
                                      if (sharedFile.sharedRecord ==
                                          SharedRecod.ShareReport) {
                                        revokeReport();
                                      } else if (sharedFile.sharedRecord ==
                                          SharedRecod.SharedPrescription) {
                                        revokePrescription();
                                      } else if (sharedFile.sharedRecord ==
                                          SharedRecod.ShareAppointment) {
                                        revokeAppointment();
                                      } else {
                                        revokeMediline();
                                      }
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Yes, remove sharing",
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                text: "Remove Sharing",
                isDelete: true,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget fileInfo() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sharedFile.sharedRecord.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text("Shared with ${sharedFile.user.name}"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void downloadFile(
    Future<String?> Function(String) getUrl,
    String fileName,
  ) async {
    String? url;
    try {
      url = await getUrl(sharedFile.id);
    } catch (e) {
      showToast("Something went wrong!");
      return;
    }
    if (url == null) {
      showToast("URL not found!");
      return;
    }

    await FileDownloadHandler.downloadFile(fileName, url);
  }

  void downloadPrescription() => downloadFile(
        SharedFilesRepository().getPrescriptionPdfUrl,
        'prescription.pdf',
      );

  void downloadReport() => downloadFile(
        SharedFilesRepository().getReportPdfUrl,
        'report.pdf',
      );

  void downloadAppointment() {}

  void downloadMediline() {}

  Future<void> revokeSharing({
    required Function revokeFunction,
    required dynamic request,
  }) async {
    try {
      await revokeFunction(request: request);
      showToast("Shared file removed");
      refresh();
    } catch (e) {
      showToast("Something went wrong!");
    }
  }

  void revokeReport() async {
    final request = RevokeSharingRequest(
      patientReportId: sharedFile.id,
      reportSharedById: sharedPrefs.id ?? "",
      reportSharedToId: sharedFile.user.id,
    );

    await revokeSharing(
      revokeFunction: RecentReportsRepository().revokeShareReportToDoctor,
      request: request,
    );
  }

  void revokePrescription() async {
    final request = RevokePrescriptionSharingRequest(
      prescriptionId: sharedFile.id,
      sharedById: sharedPrefs.id ?? "",
      sharedToId: sharedFile.user.id,
    );

    await revokeSharing(
      revokeFunction: PrescriptionRepo().revokeSharePrescriptionToDoctor,
      request: request,
    );
  }

  void revokeAppointment() async {
    final request = RevokeAppointmentRequest(
      appointmentId: sharedFile.id,
      clinicId: sharedFile.user.id,
    );

    await revokeSharing(
      revokeFunction: MedilineRepository().revokeAppointmentToDoctor,
      request: request,
    );
  }

  void revokeMediline() async {
    try {
      await MedilineRepository().revokeShareMediline(
        sharedToId: sharedFile.user.id,
        patientId: sharedPrefs.patientId!,
        sharedById: sharedPrefs.id ?? "",
      );
      showToast("Shared file removed");
      refresh();
    } catch (e) {
      showToast("Something went wrong!");
    }
  }

  showDetails(BuildContext context) async {
    Widget nextScreen = const MyMedilineScreen();
    if (sharedFile.sharedRecord == SharedRecod.ShareReport) {
      GetRecentReportsData? data =
          await RecentReportsRepository().getReportById(id: sharedFile.id);
      if (data == null) {
        Fluttertoast.showToast(msg: 'Something went wrong!');
        return;
      }
      nextScreen = ReportsDetail(
        fileUrl: data.url!,
        reportsData: data,
      );
    } else if (sharedFile.sharedRecord == SharedRecod.SharedPrescription) {
      GetAllPrescriptionData? data =
          await PrescriptionRepo().getPrescriptionById(id: sharedFile.id);
      if (data == null) {
        Fluttertoast.showToast(msg: 'Something went wrong!');
        return;
      }
      nextScreen = PrescriptionDetailTabview(getAllPrescriptionData: data);
    }
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((context) => nextScreen),
      ),
    );
  }
}
