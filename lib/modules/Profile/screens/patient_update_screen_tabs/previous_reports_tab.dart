import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jatya_patient_mobile/common_components/widgets/app_alert_dialog.dart';
import 'package:jatya_patient_mobile/modules/Profile/bloc/previous_report_bloc/previousreport_bloc.dart';

import '../../../../common_components/widgets/popup_widget.dart';
import '../../widgets/previousReport/previous_report_form.dart';

class PreviousReportTab extends StatefulWidget {
  const PreviousReportTab({super.key});

  @override
  State<PreviousReportTab> createState() => _PreviousReportTabState();
}

class _PreviousReportTabState extends State<PreviousReportTab> {
  String vaccineVal1 = 'Blood Test';
  String vaccineVal2 = 'Body Test';

  bool issDateSelected = false;
  // final DateTime _date = DateTime.now();
  String vaccinDate1 = "dd/mm/yyyy";
  String vaccinDate2 = "dd/mm/yyyy";

  // Future _selectDate(BuildContext context, String vaccinationDatevalue) async {
  //   DateTime? datePicker = await showDatePicker(
  //       context: context,
  //       initialDate: _date,
  //       firstDate: DateTime(1947),
  //       lastDate: DateTime(2050));

  //   if (datePicker != null && datePicker != _date) {
  //     String selectedDate = datePicker.toString();
  //     selectedDate = selectedDate.replaceRange(10, 23, "");
  //     setState(() {
  //       if (vaccinationDatevalue == vaccinDate1) {
  //         vaccinDate1 = selectedDate;
  //       } else {
  //         vaccinDate2 = selectedDate;
  //       }

  //       issDateSelected = true;
  //     });
  //   }
  // }

  @override
  void initState() {
    context.read<PreviousReportBloc>().add(const PreviousReportInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: BlocListener<PreviousReportBloc, PreviousReportState>(
        listener: (context, state) {
          if (state is PreviousReportUploadedState) {
            showPopup(context: context, child: successMessage(context));
            // context
            //     .read<PreviousReportBloc>()
            //     .add(const PreviousReportInitialEvent());
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<PreviousReportBloc, PreviousReportState>(
                builder: (context, state) {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.reports.length,
                    itemBuilder: (context, index) {
                      return PreviousReportForm(
                        editable: false,
                        report: state.reports[index],
                      );
                    },
                  );
                },
              ),
              const PreviousReportForm()
            ],
          ),
        ),
      ),
    );
  }

  AppAlertDialog successMessage(BuildContext context) {
    return AppAlertDialog(
        iconColor: Colors.green,
        icon: const Icon(
          Icons.check,
          color: Colors.white,
        ),
        height: MediaQuery.of(context).size.height * 0.2,
        child: Column(
          children: [
            const Text("Report Added Successfully"),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                onPressed: () {
                  context
                      .read<PreviousReportBloc>()
                      .add(const PreviousReportInitialEvent());

                  Navigator.pop(context);
                },
                child: const Text("Ok"),
              ),
            )
          ],
        ));
  }
}
