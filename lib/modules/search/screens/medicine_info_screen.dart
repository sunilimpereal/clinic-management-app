import 'package:flutter/material.dart';
import 'package:jatya_patient_mobile/modules/search/models/medicine_response.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MedicineInfo extends StatefulWidget {
  final GetMedicineData medicineData;
  const MedicineInfo({super.key, required this.medicineData});

  @override
  State<MedicineInfo> createState() => _MedicineInfoState();
}

class _MedicineInfoState extends State<MedicineInfo> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              _progress = progress;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://www.drugs.com/search.php?searchterm=${widget.medicineData.title}'));
  }

  int _progress = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.medicineData.title),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(value: _progress / 100),
          Expanded(child: WebViewWidget(controller: controller)),
        ],
      ),
    );
  }
}
