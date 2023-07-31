import 'dart:developer';
import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(String coordinates) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$coordinates';
    var uri = Uri.parse(googleUrl);
    log("googleUrl $googleUrl");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not open the map.';
    }
  }
}
