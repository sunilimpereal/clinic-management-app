import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common_components/widgets/common_image_holder.dart';
import '../../../../common_components/widgets/common_upload_box.dart';
import '../../../../common_components/widgets/date_picker.dart';
import '../../../../common_components/widgets/error_alert_dialog.dart';
import '../../../../common_components/widgets/popup_widget.dart';
import '../../../Auth/widgets/input_text_field.dart';
import '../../bloc/previous_report_bloc/previousreport_bloc.dart';
import '../../models/prev_reports/get_previous_reports_response.dart';

class PreviousReportForm extends StatefulWidget {
  final ReportDatum? report;
  final bool? editable;
  const PreviousReportForm({super.key, this.report, this.editable});

  @override
  State<PreviousReportForm> createState() => _PreviousReportFormState();
}

class _PreviousReportFormState extends State<PreviousReportForm> {
  TextEditingController? _textEditingController;
  Timer? _debouncer;
  @override
  void initState() {
    _textEditingController = TextEditingController(
      text: widget.report?.reportName,
    );
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController?.dispose();
    _debouncer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IgnorePointer(
          ignoring: !(widget.editable ?? true),
          child: Column(
            children: [
              BlocBuilder<PreviousReportBloc, PreviousReportState>(
                builder: (context, state) {
                 
                  return AbsorbPointer(
                    absorbing: widget.report != null ? true : false,
                    child: InputTextField(labelText: "REPORT TYPE", textEditingController: _textEditingController, onChanged: (value) {}),
                  );
                },
              ),
              const SizedBox(
                height: 5,
              ),
              BlocBuilder<PreviousReportBloc, PreviousReportState>(
                builder: (context, state) {
                  return DatePicker(
                    title: "REPORT DATE",
                    width: MediaQuery.of(context).size.width,
                    initialDate: widget.report != null
                        ? widget.report!.reportDate.toString()
                        : state.date,
                    lastDate: DateTime.now(),
                    onChanged: (value) =>
                        context.read<PreviousReportBloc>().add(
                              PreviousReportDateChangedEvent(
                                date: value.toString(),
                              ),
                            ),
                  );
                },
              ),
            ],
          ),
        ),
        BlocBuilder<PreviousReportBloc, PreviousReportState>(
            builder: (context, state) {
          return GestureDetector(
              onTap: () async {
                if (widget.report != null) {
                  return;
                }
                if (_textEditingController == null ||
                    _textEditingController!.text.isEmpty) {
                  showPopup(
                      context: context,
                      child:
                          const ErrorAlertDialog(error: "Enter Report type"));
                  return;
                }
                if (state.date == null) {
                  showPopup(
                      context: context,
                      child: const ErrorAlertDialog(error: "Select Date"));
                  return;
                }
                FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  type: FileType.custom,
                  allowedExtensions: ['jpg', 'pdf', 'doc', 'heic'],
                ).then((value) {
                  if (value != null) {
                    log("image  ${value.files.single.path}");
                    context
                        .read<PreviousReportBloc>()
                        .add(PreviousReportUploadReportEvent(
                          file: File(value.files.single.path ?? ''),
                          fileName: _textEditingController!.text,
                        ));
                    _textEditingController!.clear();
                    context
                        .read<PreviousReportBloc>()
                        .add(const PreviousReportStateClearEvent());
                    context
                        .read<PreviousReportBloc>()
                        .add(const PreviousReportInitialEvent());
                  }
                });
              },
              child: widget.report != null
                  ? ReportHolder(report: widget.report!)
                  : CommonUploadReport(
                      isDisabled: _textEditingController == null ||
                          _textEditingController!.text.isEmpty ||
                          state.date == null,
                    ));
        }),
      ],
    );
  }
}
