import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic_app/common_components/widgets/app_alert_dialog.dart';
import 'package:clinic_app/common_components/widgets/error_alert_dialog.dart';
import 'package:clinic_app/modules/Profile/bloc/vaccinations_bloc/vaccinations_bloc.dart';

import '../../../../common_components/widgets/popup_widget.dart';
import '../../widgets/vaccinations/vaccination_form.dart';

class VaccinationTab extends StatefulWidget {
  const VaccinationTab({super.key});

  @override
  State<VaccinationTab> createState() => _VaccinationTabState();
}

class _VaccinationTabState extends State<VaccinationTab> {
  @override
  void initState() {
    context
        .read<VaccinationsBloc>()
        .add(const VaccinationsGetVaccineListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VaccinationsBloc, VaccinationsState>(
      listener: (context, state) {
        if (state is VaccinationCreated) {
          showPopup(context: context, child: successMessage(context));
          // context.read<VaccinationsBloc>().add(const VaccinationReInitializeEvent());
        }
        if (state is VaccinationsErrorState) {
          showPopup(
              context: context, child: ErrorAlertDialog(error: state.error));
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            vaccineList(),
            const VaccinationEntryForm(),
          ],
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
            const Text("Vaccination Added Successfully"),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                onPressed: () {
                  context
                      .read<VaccinationsBloc>()
                      .add(const VaccinationsGetVaccineListEvent());

                  Navigator.pop(context);
                },
                child: const Text("Ok"),
              ),
            )
          ],
        ));
  }

  Widget vaccineList() {
    return BlocBuilder<VaccinationsBloc, VaccinationsState>(
      builder: (context, state) {
        if (state.vaccineList.length > 1) {
          state.vaccineList.sort(
            (a, b) => b!.vaccinationDate!.compareTo(a!.vaccinationDate!),
          );
        }
        return Column(
          children: state.vaccineList
              .map((e) => VaccinationEntryForm(
                editable: false,
                    vaccine: e,
                  ))
              .toList(),
        );
      },
    );
  }
}
