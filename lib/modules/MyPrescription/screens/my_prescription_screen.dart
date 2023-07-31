import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jatya_patient_mobile/common_components/widgets/common_drawer.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/bloc/myPrescriptionBloc/my_prescription_bloc.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/models/get_all_clinic/get_all_clinic_response.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/models/latest_prescription.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/widgets/my_prescription_tabview.dart';

class MyPrescriptionScreen extends StatefulWidget {
  //final List<GetAllClinicData>? clinicLIstData;
  const MyPrescriptionScreen({super.key});

  @override
  State<MyPrescriptionScreen> createState() => _MyPrescriptionScreenState();
}

class _MyPrescriptionScreenState extends State<MyPrescriptionScreen> {
  @override
  void initState() {
    context.read<MyPrescriptionBloc>().add(GetAllMyPrescriptionEvent());
    //BlocProvider.of<MyPrescriptionBloc>(context)
      //  .add(GetAllMyPrescriptionEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Prescription")),
      body: BlocBuilder<MyPrescriptionBloc, MyPrescriptionState>(
        builder: (context, state) {
          if (state is MyPrescriptionBlocloading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MyPrescriptionBlocSuccess) {
            return PrescriptionTabView(
              //clinicList: widget.clinicLIstData ?? [],
              data: state.getAllPrescriptions??[],
              clinicList: state.clinicList ?? [],
            );
          } else if (state is MyPrescriptionBlocFailure) {
            return body(context, null);
          } else {
            return Center(child: Text("Something went wrong: $state"));
          }
        },
      ),
      drawer: const CommonDrawer(),
    );
  }

  Widget body(BuildContext context,
      GetAllPrecriptionResposnse? getAllPrecriptionResposnse) {
    return const Material(
      child: Text('Something went wrong'),
    );
  }
}
