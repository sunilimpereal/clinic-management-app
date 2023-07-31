import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

import '../../../../common_components/widgets/popup_widget.dart';
import '../../../../common_components/widgets/success_alert_dialog.dart';
import '../../bloc/vaccinations_bloc/vaccinations_bloc.dart';
import '../../models/vaccination/get_vaccine_response.dart';
import '../../services/vaccine_repository.dart';
import 'package:http/http.dart' as http;

class VaccineCertificateImage extends StatefulWidget {
  final VaccineDatum vaccineDatum;

  const VaccineCertificateImage({
    super.key,
    required this.vaccineDatum,
  });

  @override
  State<VaccineCertificateImage> createState() => _VaccineCertificateImageState();
}

class _VaccineCertificateImageState extends State<VaccineCertificateImage> {
  Future<File> getFileFromUrl(String url, {name}) async {
    var fileName = 'testonline';
    if (name != null) {
      fileName = name;
    }
    try {
      var data = await http.get(Uri(path: url));
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$fileName.pdf");
      print(dir.path);
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  String urlPDFPath = "";
  bool exists = true;
  final int _totalPages = 0;
  final int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController? _pdfViewController;
  bool loaded = false;
  @override
  void initState() {
    if (widget.vaccineDatum.url?.contains("pdf") ?? false) {
      getFileFromUrl(widget.vaccineDatum.url ?? "").then(
        (value) {
          log(value.exists().toString());
          setState(() {
            if (value != null) {
              urlPDFPath = value.path;
              loaded = true;
              exists = true;
            } else {
              exists = false;
            }
          });
        },
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Column(
          children: [
            widget.vaccineDatum.url?.contains("pdf") ?? false
                ? SizedBox(
                    height: 150,
                    child: Container(
                      height: 150,
                      width: 100,
                      padding: const EdgeInsets.all(5),
                      child: PdfViewer.openFutureFile(
                        () async => (await DefaultCacheManager().getSingleFile(widget.vaccineDatum.url ?? '')).path,
                        params: const PdfViewerParams(padding: 0),
                      ),
                    ))
                : Container(
                    height: 150,
                    decoration: const BoxDecoration(),
                    child: widget.vaccineDatum.url == null
                        ? Image.file(
                            File(widget.vaccineDatum.url ?? ''),
                            fit: BoxFit.cover,
                          )
                        : Image.network(widget.vaccineDatum.url ?? ''),
                  ),
            Container(
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: Colors.grey.shade200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.vaccineDatum.vaccinationName ?? ''),
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      //delete
                      VaccineRepository().deleteVaccine(vaccineId: widget.vaccineDatum.id ?? '').then((value) {
                        if (value != null) {
                          context.read<VaccinationsBloc>().add(const VaccinationsGetVaccineListEvent());
                          showPopup(context: context, child: const SuccessAlertDialog(message: "Vaccine Deteted successfully"));
                        }
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
