import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic_app/common_components/widgets/date_picker.dart';
import 'package:clinic_app/modules/Profile/widgets/vaccinations/certificate_image.dart';

import '../../../../common_components/widgets/common_upload_box.dart';
import '../../../../common_components/widgets/error_alert_dialog.dart';
import '../../../../common_components/widgets/popup_widget.dart';
import '../../bloc/vaccinations_bloc/vaccinations_bloc.dart';
import '../../models/vaccination/get_vaccine_response.dart';
import '../../models/vaccination/vaccine.dart';

class VaccinationEntryForm extends StatefulWidget {
  final VaccineDatum? vaccine;
  final bool? editable;
  const VaccinationEntryForm({super.key, this.vaccine, this.editable});

  @override
  State<VaccinationEntryForm> createState() => _VaccinationEntryFormState();
}

class _VaccinationEntryFormState extends State<VaccinationEntryForm> {
  TextEditingController? _textEditingController;
  FocusNode? _focusNode;
  @override
  void initState() {
    _textEditingController = TextEditingController(
      text: widget.vaccine?.vaccinationName,
    );
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    super.dispose();
  }

  void _handleTapOutside() {
    if (_focusNode!.hasFocus) {
      _focusNode?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTapOutside,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 24),
          IgnorePointer(
            ignoring: !(widget.editable ?? true),
            child: Column(
              children: [
                BlocBuilder<VaccinationsBloc, VaccinationsState>(
                  builder: (context, state) {
                    // return DropDownWidget(
                    //   title: "VACCINATION NAME",
                    //   options: state.vaccineOptions,
                    //   selectedItem: widget.vaccine != null
                    //       ? DropDownItem(name: widget.vaccine!.vaccinationName!)
                    //       : state.vaccineName,
                    //   onChanged: (value) => context
                    //       .read<VaccinationsBloc>()
                    //       .add(
                    //           VaccinationsNameChangedEvent(vaccineName: value)),
                    // );
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: FocusScope(
                        node: FocusScopeNode(),
                        child: TextField(
                          onChanged: (value) {
                            context.read<VaccinationsBloc>().add(
                                  VaccinationsNameChangedEvent(
                                    vaccineName: value,
                                  ),
                                );
                          },
                          focusNode: _focusNode,
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            label: const Text(
                              'VACCINATION NAME',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            contentPadding: const EdgeInsets.all(4),
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                BlocBuilder<VaccinationsBloc, VaccinationsState>(
                  builder: (context, state) {
                    return DatePicker(
                        title: "VACCINATION DATE",
                        width: MediaQuery.of(context).size.width,
                        initialDate: widget.vaccine != null
                            ? widget.vaccine!.vaccinationDate.toString()
                            : state.date,
                        onChanged: (value) => context
                            .read<VaccinationsBloc>()
                            .add(VaccinationsDateChangedEvent(
                                date: value.toString())));
                  },
                ),
              ],
            ),
          ),
          BlocBuilder<VaccinationsBloc, VaccinationsState>(
            builder: (context, state) {
              // log("message${state.image?.path}");
              log(state.vaccineList.toString());
              return GestureDetector(
                  onTap: () async {
                    if (widget.vaccine != null) {
                      return;
                    }
                    if (state.vaccineName == null) {
                      showPopup(
                          context: context,
                          child: const ErrorAlertDialog(
                              error: "Select Vaccine Name"));
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
                        context.read<VaccinationsBloc>().add(
                            VaccinationsImageChangedEvent(
                                image: File(value.files.single.path ?? '')));
                        context
                            .read<VaccinationsBloc>()
                            .add(VaccinationsAddVaccinationDetailEvent(
                                vaccine: Vaccine(
                              date: state.date ?? DateTime.now().toString(),
                              image: state.image ??
                                  File(value.files.single.path ?? ''),
                              vaccineName: state.vaccineName!,
                            )));
                        context
                            .read<VaccinationsBloc>()
                            .add(const VaccinationsGetVaccineListEvent());
                      }
                    });
                  },
                  child: widget.vaccine != null
                      ? VaccineCertificateImage(
                          vaccineDatum: widget.vaccine!,
                        )
                      : CommonUploadReport(
                          isDisabled:
                              state.vaccineName == null || state.date == null,
                        ));
            },
          ),
        ],
      ),
    );
  }
}
