import 'package:flutter/material.dart';
import 'package:jatya_patient_mobile/utils/helper/helper.dart';
import 'package:jatya_patient_mobile/utils/helper/map_utils.dart';

import '../../utils/constants/image_konstants.dart';

class MapIcon extends StatelessWidget {
  final String? geoLocation;
  const MapIcon({Key? key, this.geoLocation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        geoLocation != null && geoLocation!.isNotEmpty
            ? MapUtils.openMap(geoLocation!)
            : WidgetHelper.showToast("No location found");
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.12,
        height: MediaQuery.of(context).size.width * 0.12,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.black,
            image: const DecorationImage(
              image: AssetImage(ImagesConstants.mapIcon),
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
