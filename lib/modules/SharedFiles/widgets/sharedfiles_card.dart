import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jatya_patient_mobile/modules/SharedFiles/models/sharedfiles_model.dart';
import 'package:jatya_patient_mobile/modules/SharedFiles/widgets/shared_files_bottomsheet.dart';

import '../../../utils/constants/color_konstants.dart';
import '../../../utils/constants/image_konstants.dart';

class SharedFilesCard extends StatelessWidget {
  final SharedFileData sharedfiles;
  final Function refresh;
  const SharedFilesCard(
      {super.key, required this.sharedfiles, required this.refresh});

  @override
  Widget build(BuildContext context) {
    log("Current time: ${DateTime.now().toUtc()}");
    log("Creation time: ${sharedfiles.createdAt}");
    log("Difference: ${DateTime.now().difference(sharedfiles.createdAt)}");
    return InkWell(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) => ShareFilesBottomSheet(
                    sharedFile: sharedfiles,
                    refresh: refresh,
                  ));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            // width: 366,
            // height: 180,
            decoration: BoxDecoration(
                border:
                    Border.all(width: 0.5, color: ColorKonstants.primaryColor),
                borderRadius: BorderRadius.circular(8),
                color: ColorKonstants.primarySwatch.shade50),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    medilineDetail(),
                    medilineDescription(),
                  ],
                )),
          ),
        ));
  }

  Widget medilineDetail() {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor:
              Colors.grey.shade200, // Set the background color of the circle
          child: SvgPicture.asset(
            ImagesConstants.medilineDrawer,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getLabel(sharedfiles.sharedRecord),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // fontSize: 18,
                      color: ColorKonstants.headingTextColor,
                    ),
                  ),
                  // verifiedTag(context),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Text("Shared ${formatDuration(
                    DateTime.now().difference(sharedfiles.createdAt.toLocal()))} ago",
                style: TextStyle(
                    fontSize: 12,
                    color: ColorKonstants.subHeadingTextColor.withOpacity(0.6)),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget medilineDescription() {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Row(children: [
          const SizedBox(
            width: 50,
          ),
          CircleAvatar(
              radius: 16,
              backgroundImage: Image.network(
                sharedfiles.user.photo??"",
                errorBuilder: (context, error, stackTrace) {
                  return SvgPicture.asset(
                    ImagesConstants.medilineDrawer,
                  );
                },
              ).image),
          const SizedBox(width: 8),
          Text(
            sharedfiles.user.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
                color: ColorKonstants.headingTextColor,
                fontWeight: FontWeight.bold),
          ),
        ]));
  }

  String formatDuration(Duration duration) {
    if (duration.inSeconds < 60) {
      return '${duration.inSeconds} seconds';
    } else if (duration.inMinutes < 60) {
      return '${duration.inMinutes} minutes';
    } else if (duration.inHours < 24) {
      return '${duration.inHours} hours';
    } else if (duration.inDays < 30) {
      return '${duration.inDays} days';
    } else if (duration.inDays < 365) {
      int months = duration.inDays ~/ 30;
      return '$months months';
    } else {
      int years = duration.inDays ~/ 365;
      return '$years years';
    }
  }

  String getLabel(SharedRecod sharedRecord) {
    switch (sharedRecord) {
      case SharedRecod.ShareAppointment:
        return "Appointment";
      case SharedRecod.ShareMediline:
        return "Mediline";
      case SharedRecod.ShareReport:
        return "Report";
      default:
        return "Prescription";
    }
  }
}
