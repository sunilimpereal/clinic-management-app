import 'package:flutter/material.dart';
import 'package:jatya_patient_mobile/modules/Reports/models/get_recent_report_response_model.dart';
import 'package:jatya_patient_mobile/modules/Reports/screens/latest_reports_tabs/report.dart';

import '../../../utils/constants/color_konstants.dart';

class ReportSearchScreen extends StatefulWidget {
  final List<GetRecentReportsData> reportsList;

  const ReportSearchScreen({Key? key, required this.reportsList})
      : super(key: key);

  @override
  _ReportSearchScreenState createState() => _ReportSearchScreenState();
}

class _ReportSearchScreenState extends State<ReportSearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<GetRecentReportsData> searchList = [];

  void searchReports(String query) {
    setState(() {
      if (query.isEmpty) {
        searchList = [];
      } else {
        searchList = widget.reportsList
            .where((report) =>
                report.reportName!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Reports'),
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
                      hintText: 'Enter Report name',
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
                title: Text(searchList[index].reportName ?? ''),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReportsDetail(
                        fileUrl: searchList[index].url ?? "",
                        // Pass the imageUrl to ReportsDetail
                        reportsData: searchList[
                            index], // Pass the reportsData to ReportsDetail
                      ),
                    ),
                  );
                },
              );
            },
          );
  }
}
