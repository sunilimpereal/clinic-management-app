import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class AppInfoScreen extends StatefulWidget {
  const AppInfoScreen({
    Key? key,
    required this.title,
    required this.filePath,
  }) : super(key: key);
  final String title;
  final String filePath;
  @override
  State<AppInfoScreen> createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends State<AppInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: PdfViewer.openAsset(widget.filePath),
      ),
    );
  }
}
