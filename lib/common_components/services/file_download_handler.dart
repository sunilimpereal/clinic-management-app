import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

/*class FileDownloadHandler {
  static Future<bool> downloadFile(String fileName, String url) async {
    try {
      String path = '/storage/emulated/0/Download/$fileName';
      File file = File(path);
      http.Response res = await http.get(Uri.parse(url));
      file.writeAsBytes(res.bodyBytes);
      Fluttertoast.showToast(msg: 'File Downloaded at Downloads folder');
      return true;
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error while downloading file');
    }
    return false;
  }
}*/

class FileDownloadHandler {
  static Future<bool> downloadFile(String fileName, String url) async {
    try {
      String path = '/storage/emulated/0/Download/';
      File file = File('$path$fileName');

      // Check if the file already exists in the specified folder
      if (await file.exists()) {
        String originalFileName = fileName;

        DateTime now = DateTime.now();
        String formattedDate = DateFormat('MMM dd,').format(now);

        String formattedTime = DateFormat('h:mm:ss a').format(now);

        formattedDate = formattedDate.replaceAll(RegExp(r'[\s,]'), '');
        formattedTime = formattedTime.replaceAll(RegExp(r'[:\s]'), '');
        fileName = '${formattedDate}_${formattedTime}_$originalFileName';

        file = File('$path$fileName');
      }

      // Download the file and save it
      http.Response res = await http.get(Uri.parse(url));
      file.writeAsBytes(res.bodyBytes);

      Fluttertoast.showToast(msg: 'File Downloaded at Downloads folder');
      return true;
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error while downloading file');
    }
    return false;
  }
}

