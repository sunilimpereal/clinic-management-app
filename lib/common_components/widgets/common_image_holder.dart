import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:clinic_app/common_components/widgets/popup_widget.dart';
import 'package:clinic_app/common_components/widgets/success_alert_dialog.dart';
import 'package:clinic_app/modules/Profile/bloc/previous_report_bloc/previousreport_bloc.dart';
import 'package:clinic_app/modules/Profile/services/previous_report_repository.dart';
import 'package:clinic_app/utils/constants/color_konstants.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

import '../../modules/Profile/models/prev_reports/get_previous_reports_response.dart';

// ignore: must_be_immutable
class ReportHolder extends StatelessWidget {
  ReportDatum report;
  XFile? reportDoc;

  ReportHolder({super.key, required this.report, this.reportDoc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            height: 280,
            width: 358,
            decoration: BoxDecoration(
              color: Colors.white10,
              border: Border.all(color: Colors.grey),
            ),
            padding: const EdgeInsets.only(left: 32, right: 32, bottom: 20),
            child: reportDoc == null
                ? report.url.contains("pdf")
                    ? PdfViewer.openFutureFile(
                        () async => (await DefaultCacheManager().getSingleFile(report.url)).path,
                        params: const PdfViewerParams(padding: 0),
                      )
                    : Image.network(report.url)
                : Image.file(File(reportDoc!.path)), 
          ),
          Positioned(
            top: 218,
            left: 1.5,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: const Offset(0, -1), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(5),
                color: const Color.fromRGBO(248, 248, 248, 1),
              ),
              height: 60,
              width: 343,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(
                    report.reportName,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                  IconButton(
                      onPressed: () {
                        PreviousReportRepository().deleteReport(reportId: report.id).then((value) {
                          if (value != null) {
                            context.read<PreviousReportBloc>().add(const PreviousReportInitialEvent());
                            showPopup(context: context, child: const SuccessAlertDialog(message: "Report Deteted successfully"));
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.delete_rounded,
                        color: ColorKonstants.primarySwatch,
                      )),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
