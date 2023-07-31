import 'dart:developer';

import 'package:flutter/material.dart';

import '../../models/patient/get_patient_details_response.dart';
import '../../widgets/allergies/allergy_item.dart';

class AllergiesTab extends StatefulWidget {
  final Allergies allergies;
  final Function(bool) isEdited;
  const AllergiesTab({
    super.key,
    required this.allergies,
    required this.isEdited,
  });

  @override
  State<AllergiesTab> createState() => _AllergiesTabState();
}

class _AllergiesTabState extends State<AllergiesTab> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 25),
      child: SingleChildScrollView(
        child: Column(children: [
          AllergyItemTile(
            title: "Medicines",
            iconData: Icons.medication_liquid_sharp,
            image: "",
            items: widget.allergies.medicineAllergies,
            onChanged: (list) {
              print("allergyedited");
              log(list.toString());
              widget.allergies.medicineAllergies = list;
              widget.isEdited(true);
            },
            selectedItems: const [
              "Anitibiotics",
            ],
          ),
          AllergyItemTile(
            title: "Food & Diary Products",
            image: "",
            items: widget.allergies.foodAllergies,
            onChanged: (list) {
              widget.allergies.foodAllergies = list;
              widget.isEdited(true);
            },
            selectedItems: const [
              "Anitibiotics",
            ],
            iconData: Icons.lunch_dining_outlined,
          ),
          AllergyItemTile(
            title: "Pet & Furry Animals",
            image: "",
            iconData: Icons.pets_rounded,
            items: widget.allergies.petAllergies,
            onChanged: (list) {
              widget.allergies.petAllergies = list;
              widget.isEdited(true);
            },
            selectedItems: const [
              "Anitibiotics",
            ],
          ),
        ]),
      ),
    );
  }
}
