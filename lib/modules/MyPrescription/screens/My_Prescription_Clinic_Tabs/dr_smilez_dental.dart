import 'package:flutter/material.dart';
import 'package:clinic_app/modules/MyPrescription/models/latest_prescription.dart';
import 'package:clinic_app/modules/MyPrescription/screens/prescription_detail_tabview.dart';
import 'package:clinic_app/modules/MyPrescription/widgets/clinic_list_item.dart';

class DRSmilezClinicTab extends StatelessWidget {
  List<GetAllPrescriptionData> prescriptionList;
  DRSmilezClinicTab({
    super.key,
    required this.prescriptionList,
  });

  @override
  Widget build(BuildContext context) {
    return prescriptionList.isEmpty
        ? const Center(
            child: Text("No Prescriptions"),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrescriptionDetailTabview(
                        getAllPrescriptionData: prescriptionList[index],
                      ),
                    ),
                  );
                },
                child: ClinicListItem(
                  clinicModel: prescriptionList[index],
                ),
              );
            },
            itemCount: prescriptionList.length,
          );
  }
}
