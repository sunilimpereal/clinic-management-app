import 'package:flutter/material.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/models/latest_prescription.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/screens/prescription_detail_tabview.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/widgets/clinic_list_item.dart';

class SingleClinicPrescription extends StatefulWidget {
  final List<GetAllPrescriptionData> getAllPrescriptionData;
  //final GetAllClinicData clinicData;
  const SingleClinicPrescription({
    super.key, required this.getAllPrescriptionData,
    //required this.clinicData,
  });

  @override
  State<SingleClinicPrescription> createState() =>
      _SingleClinicPrescriptionState();
}

class _SingleClinicPrescriptionState extends State<SingleClinicPrescription> {
  //final GetPrescriptionCliicWiseBloc _getPrescriptionBloc = GetPrescriptionCliicWiseBloc();

  /*@override
  void initState() {
    _getPrescriptionBloc.add(GetAllMyPrescriptionByClinicIDEvent(
        //widget.clinicData.clinic?.id ?? "2"
        ));
    super.initState();
  }

  @override
  void dispose() {
    _getPrescriptionBloc.close();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    List<GetAllPrescriptionData>? data;
    return data == null
        ? const Center(
      child: Text("No prescription Found"),
    )
        : ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PrescriptionDetailTabview(
                      getAllPrescriptionData: data[index],
                    ),
              ),
            );
          },
          child: ClinicListItem(
            clinicModel: data[index],
          ),
        );
      },
      itemCount: data.length,
    );
  }

       /*BlocBuilder<GetPrescriptionCliicWiseBloc,
          GetPrescriptionCliicWiseState>(
        bloc: _getPrescriptionBloc,
        builder: (context, state) {
          if (state is GetPrescriptionCliicWiseLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetPrescriptionCliicWiseSuccess) {
            return body(context, state.getAllPrescriptions.data);
          } else if (state is GetPrescriptionCliicWiseFailure) {
            return body(context, null);
          } else {
            return const Center(child: Text("Something went hi"));
          }
        },
      ),*/
  }

  Widget body(BuildContext context, List<GetAllPrescriptionData>? data) {
    //log("id is${widget.clinicData.clinic?.id} and data is ${data?.length.toString()} a");

    return data == null
        ? const Center(
            child: Text("No prescription Found"),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrescriptionDetailTabview(
                        getAllPrescriptionData: data[index],
                      ),
                    ),
                  );
                },
                child: ClinicListItem(
                  clinicModel: data[index],
                ),
              );
            },
            itemCount: data.length,
          );
  }

