import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:clinic_app/common_components/model/errors/clinic_working_hours_model.dart';

import '../../../utils/constants/color_konstants.dart';

class ClinicWorkingHourWidget extends StatefulWidget {
  final ClinicWorkingHour workingHours;
  const ClinicWorkingHourWidget({Key? key, required this.workingHours})
      : super(key: key);

  @override
  State<ClinicWorkingHourWidget> createState() =>
      _ClinicWorkingHourWidgetState();
}

class _ClinicWorkingHourWidgetState extends State<ClinicWorkingHourWidget> {
  double deviceHeight = 0;
  double deviceWidth = 0;

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return isWorkingHoursAvailable(widget.workingHours) == false
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(child: textHeading("CONSULTING HOURS")),
                Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8, left: 0, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (isWorkingHourAvailable(widget.workingHours.monday))
                          workingHoursTile(
                              "Monday", widget.workingHours.monday!),
                        if (isWorkingHourAvailable(widget.workingHours.tuesday))
                          workingHoursTile(
                              "Tuesday", widget.workingHours.tuesday!),
                        if (isWorkingHourAvailable(
                            widget.workingHours.wednesday))
                          workingHoursTile(
                              "Wednesday", widget.workingHours.wednesday!),
                        if (isWorkingHourAvailable(
                            widget.workingHours.thursday))
                          workingHoursTile(
                              "Thursday", widget.workingHours.thursday!),
                        if (isWorkingHourAvailable(widget.workingHours.friday))
                          workingHoursTile(
                              "Friday", widget.workingHours.friday!),
                        if (isWorkingHourAvailable(
                            widget.workingHours.saturday))
                          workingHoursTile(
                              "Saturday", widget.workingHours.saturday!),
                        if (isWorkingHourAvailable(widget.workingHours.sunday))
                          workingHoursTile(
                              "Sunday", widget.workingHours.sunday!),
                      ],
                    ))
              ],
            ),
          );
  }

  Widget workingHoursTile(
    String weekDay,
    List<Day> day,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customTextFieldBlack(weekDay, ColorKonstants.subHeadingTextColor),
          ],
        ),
        SizedBox(
          width: deviceWidth * 0.4,
          child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: day.length,
              itemBuilder: (context, index) {
                String openingTime =
                    DateFormat('hh:mm a').format(day[index].openingTime);

                String closingTime =
                    DateFormat('hh:mm a').format(day[index].closingTime);
                return Text("$openingTime - $closingTime",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorKonstants.textgrey,
                      height: 1.5,
                    ));
              }),
        ),
      ],
    );
  }

  Widget customTextFieldBlack(String val, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        val,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: color,
          height: 1.5,
        ),
      ),
    );
  }

  bool isWorkingHourAvailable(List<Day>? day) {
    if (day != null) {
      if (day.isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  bool isWorkingHoursAvailable(ClinicWorkingHour workingHours) {
    if (isWorkingHourAvailable(workingHours.monday) ||
        isWorkingHourAvailable(workingHours.tuesday) ||
        isWorkingHourAvailable(workingHours.wednesday) ||
        isWorkingHourAvailable(workingHours.thursday) ||
        isWorkingHourAvailable(workingHours.friday) ||
        isWorkingHourAvailable(workingHours.saturday) ||
        isWorkingHourAvailable(workingHours.sunday)) {
      return true;
    }
    return false;
  }

  Widget textHeading(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: ColorKonstants.textgrey,
        ),
      ),
    );
  }
}
