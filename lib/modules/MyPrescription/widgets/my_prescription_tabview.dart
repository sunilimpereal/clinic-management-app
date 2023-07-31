import 'package:flutter/material.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/models/latest_prescription.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/screens/My_Prescription_Clinic_Tabs/all_clinics_tab.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/widgets/search_prescription.dart';
import 'package:jatya_patient_mobile/modules/NewAppointment/model/get_clinic_detail_response.dart';

class PrescriptionTabView extends StatefulWidget {
  final List<GetAllPrescriptionData> data;
  final List<Clinic> clinicList;

  PrescriptionTabView({super.key, required this.clinicList, required this.data});

  @override
  State<PrescriptionTabView> createState() => _PerscriptionTabViewState();
}

class _PerscriptionTabViewState extends State<PrescriptionTabView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  //var listOfClinics = [];
  SortOption _selectedSortOption = SortOption.Date;

  @override
  void initState() {
    //int clinicListLength = widget.clinicList.length ?? 0;
    //listOfClinics = widget.clinicList ?? ["Health Clinic", "Smile Health Clinic"];
    _tabController = TabController(vsync: this, length: (widget.clinicList.length  + 1));

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    List<GetAllPrescriptionData>? sortedData = widget.data;
    if (_selectedSortOption == SortOption.Date) {
      sortedData.sort((a, b) => b.createdDate!.compareTo(a.createdDate!));
    } else if (_selectedSortOption == SortOption.Name) {
      sortedData.sort((a, b) => a.name!.compareTo(b.name!));
    }
    return Center(
      child: Column(
        children: [
          // Remove tab structure when only one tab is there.
          Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ))),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      tabs: [
                        const Tab(
                          text: "All clinics",
                        ),
                        ...widget.clinicList
                            .map((e) => Tab(
                          text: e.name,
                        ))
                            .toList()
                      ])),
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.fast),
              controller: _tabController,
              children: [
                AllClinicTab(
                  prescriptionList: widget.data ,
                ),
                ...widget.clinicList
                    .map((e) => AllClinicTab(
                    prescriptionList: widget.data.where((element) => element.clinicId==e.id).toList()))
                    .toList()
              ],
            ),
          ),
          BottomAppBar(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    icon: const Icon(
                      Icons.sort,
                      color: Colors.blue,
                    ),
                    label: const Text(
                      'SORT',
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () {
                      _sortSheet(context);
                    },
                  ),
                  Container(
                    height: 40.0, // Set a fixed height for the vertical divider
                    width: 1.0,
                    color: Colors.grey.shade300,
                  ),
                  TextButton.icon(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.blue,
                    ),
                    label: const Text(
                      'SEARCH',
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrescriptionSearchScreen(
                            prescriptionList: widget.data ,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _sortSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.22,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 80,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              ListTile(
                title: const Text("Sort by Date"),
                onTap: () {
                  setState(() {
                    _selectedSortOption = SortOption.Date;
                  });
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
              ListTile(
                title: const Text("Sort by Name"),
                onTap: () {
                  setState(() {
                    setState(() {
                      _selectedSortOption = SortOption.Name;
                      widget.data.sort((a, b) =>
                          a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
                    });
                  });
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

enum SortOption {
  Date, Name,
}
