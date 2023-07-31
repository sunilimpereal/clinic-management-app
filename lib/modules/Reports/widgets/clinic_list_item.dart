
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jatya_patient_mobile/modules/Reports/models/get_recent_report_response_model.dart';
import 'package:jatya_patient_mobile/utils/SharePref.dart';
import 'package:jatya_patient_mobile/utils/constants/image_konstants.dart';



class ClinicListItem extends StatelessWidget {
  final GetRecentReportsData clinicModel;
  const ClinicListItem({
    Key? key,
    required this.clinicModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String profilepic = sharedPrefs.getProfilePic == ""
        ? ImagesConstants.networkImageProfilePicPlacholder
        : sharedPrefs.getProfilePic;
    String dateString = DateFormat('dd-MM-yyyy').format(DateTime.parse(clinicModel.reportDate ?? '2021-09-01'));
    return ListTile(
      leading: SizedBox(
        width: 100,
        height: 40,
        child:  Stack(
            children: [
              Positioned(
                left: 0,
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.grey.shade300,
                  child: SvgPicture.asset(ImagesConstants.reportDrawer),
                ),
              ),
              Positioned(
                left: 30.0,
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundImage:  NetworkImage(profilepic),
                ),
              ),
              /*const Positioned(
                left: 60.0,
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundImage: AssetImage(ImagesConstants.clinicPlaceholder),
                ),
              ),*/]
        ),
      ),
      title: Text(clinicModel.reportName ?? ''),
      subtitle: Text(dateString),
    );
  }
}
