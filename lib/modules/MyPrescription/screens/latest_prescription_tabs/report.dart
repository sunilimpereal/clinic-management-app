import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../utils/constants/color_konstants.dart';
import '../../../../utils/helper/helper.dart';
import '../../models/latest_prescription.dart';

class Reports extends StatelessWidget {
  final String fileUrl;
  GetAllPrescriptionData getAllPrescriptionData;

  Reports(
  {super.key, required this.fileUrl,required this.getAllPrescriptionData });
  static Future<void> launchURL(String imageUrl) async {
    var url = imageUrl;
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw "Cannot load Url $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isPdfUrl = fileUrl.contains(".pdf") ? true : false;
    log("isPdfUrl $isPdfUrl");
    return SafeArea(
      child: Scaffold(

        body: Center(
          child: isPdfUrl
              ? PdfViewer.openFutureFile(
                () async =>
            (await DefaultCacheManager().getSingleFile(fileUrl)).path,
            params: const PdfViewerParams(padding: 10),
          )
              : Image.network(
            fileUrl,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Text(
                  'Report Not Found',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget popUpMenuButton(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: 'item1',
            child: ListTile(
              selected: true,
              onTap: () {
                Navigator.pop(context);
              },
              leading: const Padding(
                padding: EdgeInsets.only(right: 18.0),
                child:
                Icon(Icons.menu_sharp, color: ColorKonstants.primarySwatch),
              ),
              title: const Text(
                'Summary View',
                style: TextStyle(color: Colors.black26),
              ),
            ),
          ),
          PopupMenuItem(
            value: 'item2',
            child: ListTile(
              selected: true,
              onTap: () {
                //Remark: Ui is Added for Detailed View uncomment
                //below Line for getting that Adding DefaultToastMsg
                // setState(() {
                //   isDetailedView = true;
                // });
                Navigator.pop(context);
                WidgetHelper.showToast("Comming Soon");
              },
              leading: const Padding(
                padding: EdgeInsets.only(right: 18.0),
                child: Icon(Icons.people_alt_outlined,
                    color: ColorKonstants.primarySwatch),
              ),
              title: const Text(
                'Detailed View',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),


        ];
      },
    );
  }
}

