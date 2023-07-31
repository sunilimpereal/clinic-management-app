import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:intl/intl.dart';
import 'package:jatya_patient_mobile/common_components/services/file_download_handler.dart';
import 'package:jatya_patient_mobile/common_components/widgets/popup_widget.dart';
import 'package:jatya_patient_mobile/common_components/widgets/sharing_consent_dialog.dart';
import 'package:jatya_patient_mobile/modules/Reports/bloc/get_all_doctors_bloc.dart';
import 'package:jatya_patient_mobile/modules/Reports/models/get_recent_report_response_model.dart';
import 'package:jatya_patient_mobile/modules/Reports/widgets/sharedetails.dart';
import 'package:jatya_patient_mobile/utils/constants/terms_konstants.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/SharePref.dart';
import '../../../../utils/constants/color_konstants.dart';
import '../../../../utils/constants/image_konstants.dart';
import '../../../../utils/helper/helper.dart';

class ReportsDetail extends StatelessWidget {
  final String fileUrl;
  final GetRecentReportsData reportsData;

  const ReportsDetail(
      {super.key, required this.fileUrl, required this.reportsData});

  @override
  Widget build(BuildContext context) {
    String fileName = fileUrl.split('/').last;

    // Trim the filename until the extension
    RegExp regExp = RegExp(r'(.*\.(pdf|jpeg|png))');
    RegExpMatch? match = regExp.firstMatch(fileName);
    if (match != null) {
      fileName = match.group(1)!;
    } else {
      // Handle cases where the URL doesn't contain a valid extension
      fileName = 'report.pdf';
    }
    bool isPdfUrl = fileUrl.contains(".pdf") ? true : false;
    log("isPdfUrl $isPdfUrl");
    String dateString = DateFormat('dd MMM yyyy')
        .format(DateTime.parse(reportsData.reportDate ?? ''));
    String profilepic = sharedPrefs.getProfilePic == ""
        ? ImagesConstants.networkImageProfilePicPlacholder
        : sharedPrefs.getProfilePic;
    double widthOfdevice = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AppBar(
                actions: [
                  popUpMenuButton(context, fileName),
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
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(profilepic),
                ),
              ),
              Positioned(
                top: 12,
                left: widthOfdevice * 0.350,
                child: Text(
                  reportsData.reportName ?? 'Report',
                  style: const TextStyle(fontSize: 19, color: Colors.white),
                ),
              ),
              Positioned(
                top: 35,
                left: widthOfdevice * 0.350,
                child: Text(
                  dateString,
                  style: const TextStyle(fontSize: 12, color: Colors.white60),
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: isPdfUrl
              ? PdfViewer.openFutureFile(
                  () async =>
                      (await DefaultCacheManager().getSingleFile(fileUrl)).path,
                  params: const PdfViewerParams(padding: 10),
                  onError: (error) {
                    log("Error $error");
                  },
                )
              : Image.network(
                  fileUrl,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text(
                        'Report Not Found',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }

  Widget popUpMenuButton(BuildContext context, String fileName) {
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
                Navigator.pop(context);
              },
              leading: const Padding(
                padding: EdgeInsets.only(right: 18.0),
                child:
                    Icon(Icons.menu_sharp, color: ColorKonstants.primarySwatch),
              ),
              title: const Text(
                'Summary View',
                style: TextStyle(color: Colors.black26),
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
                // setState(() {
                //   isDetailedView = true;
                // });
                Navigator.pop(context);
                WidgetHelper.showToast("Comming Soon");
              },
              leading: const Padding(
                padding: EdgeInsets.only(right: 18.0),
                child: Icon(Icons.people_alt_outlined,
                    color: ColorKonstants.primarySwatch),
              ),
              title: const Text(
                'Detailed View',
                style: TextStyle(color: Colors.black),
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
                        child: ShareDetails(
                          reportsData: reportsData,
                          topHeading: 'Share your prescription details',
                        ),
                      ),
                    );
                  },
                );
              },
              leading: const Padding(
                padding: EdgeInsets.only(right: 18.0),
                child: ImageIcon(
                  AssetImage(ImagesConstants.stethoscope),
                  color: ColorKonstants.primarySwatch,
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
                FileDownloadHandler.downloadFile(fileName, fileUrl);
              },
              leading: const Padding(
                padding: EdgeInsets.only(right: 18.0),
                child: Icon(Icons.circle, color: ColorKonstants.primarySwatch),
              ),
              title: const Text(
                'Download Report',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ];
      },
    );
  }
}
