import 'package:flutter/material.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/models/latest_prescription.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/screens/latest_prescription_tabs/prescription.dart';

import '../../../utils/constants/color_konstants.dart';
import '../screens/prescription_detail_tabview.dart';

class PrescriptionSearchScreen extends StatefulWidget {
  final List<GetAllPrescriptionData> prescriptionList;

  const PrescriptionSearchScreen({Key? key, required this.prescriptionList})
      : super(key: key);

  @override
  _PrescriptionSearchScreenState createState() => _PrescriptionSearchScreenState();
}

class _PrescriptionSearchScreenState extends State<PrescriptionSearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<GetAllPrescriptionData> searchList = [];

  void searchReports(String query) {
    setState(() {
      if (query.isEmpty) {
        searchList = [];
      } else {
        searchList = widget.prescriptionList
            .where((report) =>
                report.name!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Prescription'),
      ),
      body: Column(
        children: [
          _searchField(),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8),
            child: Text(
              "${searchList.length} matches found",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: ColorKonstants.grey),
            ),
          ),
          Expanded(child: _list()),
        ],
      ),
    );
  }

  Widget _searchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.grey[200],
            ),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: TextField(
                    onChanged: searchReports,
                    controller: searchController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Enter Prescription name',
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    searchController.clear();
                  },
                  icon: const Icon(Icons.cancel),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _list() {
    return searchList.isEmpty
        ? Container()
        : ListView.builder(
            itemCount: searchList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(searchList[index].name?? ''),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrescriptionDetailTabview(
                        getAllPrescriptionData: searchList[index],
                      ),
                    ),
                  );
                },
              );
            },
          );
  }
}
