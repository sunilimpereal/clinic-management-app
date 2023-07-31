import 'package:flutter/material.dart';
import 'package:clinic_app/modules/Reports/models/get_recent_report_response_model.dart';
import 'package:clinic_app/modules/Reports/widgets/clinic_list_item.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'latest_reports_tabs/report.dart';

class AllClinicTab extends StatelessWidget {
  List<GetRecentReportsData> reportsList;

  AllClinicTab({
    Key? key,
    required this.reportsList,
  }) : super(key: key);

  Future<void> _launchURL(
      BuildContext context, GetRecentReportsData reportsData) async {
    var navigator = Navigator.of(context);
    var url = reportsData.url;
    if (url == null) {
      return;
    }
    if (await canLaunchUrlString(url)) {
      navigator.push(
        MaterialPageRoute(
          builder: (context) => ReportsDetail(
            fileUrl: url,
            reportsData: reportsData,
          ),
        ),
      );
    } else {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return reportsList.isEmpty
        ? const Center(
            child: Text("No Reports"),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _launchURL(context, reportsList[index]),
                child: ClinicListItem(
                  clinicModel: reportsList[index],
                ),
              );
            },
            itemCount: reportsList.length,
          );
  }
}
