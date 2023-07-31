import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:clinic_app/modules/MyJatya/widgets/upcoming_appointment_recipt.dart';
import 'package:clinic_app/services/health_service.dart';
import 'package:clinic_app/services/token_service.dart';
import 'package:clinic_app/utils/SharePref.dart';
import 'package:clinic_app/utils/constants/color_konstants.dart';
import 'package:clinic_app/utils/helper/helper.dart';

class SyncTile extends StatefulWidget {
  const SyncTile({super.key, this.onData});

  final void Function(dynamic data)? onData;

  @override
  State<SyncTile> createState() => _SyncTileState();
}

class _SyncTileState extends State<SyncTile> {
  final String patientId = sharedPrefs.patientId!;
  String? token;
  Map? graphData;
  bool showLoader = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: const Icon(Icons.watch),
      title: Text(
        "Save your time at the clinic by syncing your data directly from your Smartwatch",
        style: TextStyle(
          color: ColorKonstants.headingTextColor,
        ),
      ),
      onTap: () async {
        if (patientId.isNotEmpty) {
          if (Platform.isIOS) {
            setState(() {
              showLoader = true;
            });

            final data = await getAndSyncAppleHealthData(patientId);
            final data1 = await getDataForGraph(patientId);
            if (data1 != null) {
              await showSummary(context, data1);
            }
            if (data != null) {
              setState(() {
                showLoader = false;
                token = jsonEncode(data);
                graphData = data1;
                widget.onData?.call(graphData);
              });
              WidgetHelper.showToast('Syncing successful');
            } else {
              setState(() {
                showLoader = false;
              });
              WidgetHelper.showToast('Something went wrong, try again...');
            }
          } else {
            setState(() {
              showLoader = true;
            });
            final data = await getRefreshToken(patientId);

            if (data != null) {
              await showSummary(context, data);
              setState(() {
                token = '';
                showLoader = false;
                graphData = data;
                widget.onData?.call(graphData);
              });
              WidgetHelper.showToast('Syncing successful');
            } else {
              setState(() {
                showLoader = false;
              });
              WidgetHelper.showToast('Something went wrong, try again...');
            }
          }
        } else {
          WidgetHelper.showToast('Invalid data, try again...');
        }
      },
      trailing: SizedBox(
        width: 45,
        child: showLoader
            ? const CircularProgressIndicator()
            : Row(
                children: [
                  Icon(
                    token == null ? Icons.sync : Icons.check,
                    color: token == null
                        ? Theme.of(context).primaryColor
                        : Colors.green,
                    size: 16,
                  ),
                  Text(
                    token == null ? 'Sync' : 'Done',
                    style: TextStyle(
                      color: token == null
                          ? ColorKonstants.blueccolor
                          : Colors.green,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
