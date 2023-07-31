import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic_app/modules/Reports/bloc/get_recent_reports/get_all_reports_bloc.dart';
import 'package:clinic_app/modules/Reports/models/get_recent_report_response_model.dart';
import 'package:clinic_app/modules/Reports/screens/all_clinics_tab.dart';
import '../../../common_components/widgets/common_drawer.dart';
import '../../../common_components/widgets/common_tabbar.dart';
import '../widgets/search_report.dart';


class MainReportsScreen extends StatefulWidget {
  const MainReportsScreen({Key? key}) : super(key: key);

  @override
  State<MainReportsScreen> createState() => _MainReportsScreenState();
}

enum SortOption { None, Name, Date }

class _MainReportsScreenState extends State<MainReportsScreen> {
  SortOption _selectedSortOption = SortOption.None;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<GetAllRecentReportsBloc>(context)
        .add(GetAllRecentReportsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllRecentReportsBloc, GetAllReportsState>(
      builder: (context, state) {
        if (state is GetAllReportsLoading) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('My Reports'),
              elevation: 0,
            ),
            drawer: const CommonDrawer(),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is GetAllReportsSuccess) {
          return body(context, state.response);
        } else {
          return Center(child: body(context, null));
        }
      },
    );
  }

  Widget body(BuildContext context, GetAllRecentReportsResponse? response) {
    List<GetRecentReportsData> sortedList = [];
    if (response?.data != null) {
      sortedList = List<GetRecentReportsData>.from(response!.data!);

      if (_selectedSortOption == SortOption.Name) {
        sortedList.sort((a, b) {
          if (a.reportName != null && b.reportName != null) {
            // Convert report names to lowercase and then compare
            return a.reportName!.toLowerCase().compareTo(b.reportName!.toLowerCase());
          } else if (a.reportName == null && b.reportName == null) {
            return 0;
          } else if (a.reportName == null) {
            return -1;
          } else {
            return 1;
          }
        });
      } else if (_selectedSortOption == SortOption.Date) {
        sortedList.sort((a, b) {
          if (a.reportDate != null && b.reportDate != null) {
            return a.reportDate!.compareTo(b.reportDate!);
          } else if (a.reportDate == null && b.reportDate == null) {
            return 0;
          } else if (a.reportDate == null) {
            return -1;
          } else {
            return 1;
          }
        });
      }
    }

    return CommonTabBar(
      tabItems: const [
        Tab(
          text: 'All Clinics',
        ),
      ],
      tabViewItems: [
        if (response?.data == null || response!.data!.isEmpty)
          const Center(child: Text('No Reports Found'))
        else
          AllClinicTab(reportsList: sortedList),
      ],
      screenTitle: 'My Reports',
      bottomBarItems: [
        TextButton.icon(
          icon: const Icon(
            Icons.sort,
            color: Colors.blue,
          ),
          label: const Text('SORT', style: TextStyle(color: Colors.blue)),
          onPressed: () {
            _sortSheet(context);
          },
        ),
        TextButton.icon(
          icon: const Icon(
            Icons.search,
            color: Colors.blue,
          ),
          label: const Text('SEARCH', style: TextStyle(color: Colors.blue)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReportSearchScreen(reportsList: response?.data ?? []),
              ),
            );
          },
        ),

      ],
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
                    _selectedSortOption = SortOption.Name;
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
