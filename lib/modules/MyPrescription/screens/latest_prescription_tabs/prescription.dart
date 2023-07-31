import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:clinic_app/modules/MyPrescription/models/latest_prescription.dart';
import 'package:clinic_app/modules/MyPrescription/models/prescription_deatils/prescription_details.dart';

import 'package:clinic_app/modules/MyPrescription/widgets/vitals_card.dart';
import '../../../../common_components/widgets/common_drawer.dart';
import '../../../../utils/constants/color_konstants.dart';
import '../../../../utils/constants/image_konstants.dart';

class Prescription extends StatelessWidget {
  Prescription({
    super.key,
    required this.getAllPrescriptionData,
    required this.isdetailedView,
    required this.doctorDetails,
  });
  late GetAllPrescriptionData getAllPrescriptionData;
  bool isdetailedView;
  final DoctorDetails? doctorDetails;

  final ScrollController _scrollController = ScrollController();

  String originalText =
      "OD - ONE TIME A DAY, BD - TWO TIMES A DAY, TDS - THREE TIMES A DAY, QID - FOUR TIMES A DAY, HS - NIGHT ONE TIME A DAY, A/D - ONE TIME ALTERNATE DAY, ODA/C - MORNING ONE TIME A DAY EMPTY STOMACH, SOS - EMERGENCY AS AND WHEN NEEDED";

  List<String> boldWords = [
    "OD",
    "BD",
    "TDS",
    "QID",
    "HS",
    "A/D",
    "ODA/C",
    "SOS"
  ];

  RichText buildRichText(String text) {
    List<TextSpan> textSpans = [];
    List<String> words = text.split(' ');

    for (var word in words) {
      var isBold = boldWords.contains(word);
      var textStyle = TextStyle(
        fontSize: 12,
        color: Colors.grey,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      );

      textSpans.add(TextSpan(text: '$word ', style: textStyle));
    }

    return RichText(text: TextSpan(children: textSpans));
  }

  @override
  Widget build(BuildContext context) {
    return body(context, getAllPrescriptionData);
  }

  Widget body(
      BuildContext context, GetAllPrescriptionData? getAllPrescriptionData) {
    var devicesize = MediaQuery.of(context).size;
    var createdAt = getAllPrescriptionData?.createdDate;
    var dateString = '';
    var hourString = '';
    if (createdAt != null) {
      dateString = DateFormat("dd MMMM yyyy ")
          .format(DateTime.parse(createdAt))
          .toUpperCase();
      hourString = DateFormat("hh:mm a").format(DateTime.parse(createdAt));
    }
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const CommonDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Text(
                "PRECLINICAL DETAILS AS OF $dateString$hourString",
                style: const TextStyle(fontSize: 12, color: Colors.black45),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              VitalsCard(
                vitalName: 'BLOOD PRESSURE',
                vitalValue: '120/89',
                vitalUnit: 'mm/Hg',
                backgroundColor: ColorKonstants.bloodpressureBG,
                vitalCondition: VitalCondition.normal,
              ),
              const SizedBox(
                height: 20,
              ),
              VitalsCard(
                vitalName: 'Glucose',
                vitalValue: '97',
                vitalUnit: 'mg/dl',
                backgroundColor: ColorKonstants.bloodpressureBG2,
                vitalCondition: VitalCondition.normal,
              ),
              const SizedBox(
                height: 20,
              ),
              VitalsCard(
                vitalName: 'HEART RATE',
                vitalValue: '108',
                vitalUnit: 'beats per min',
                backgroundColor: ColorKonstants.bloodpressureBG3,
                vitalCondition: VitalCondition.aboveNormal,
              ),
              const SizedBox(height: 16),
              isdetailedView
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        textHeading("HISTORICAL DATA"),
                        Scrollbar(
                          isAlwaysShown: true,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                                headingRowColor: MaterialStateColor.resolveWith(
                                    (states) => ColorKonstants.bloodpressureBG2),
                                border: TableBorder.symmetric(
                                    inside: BorderSide.none),
                                columns: [
                                  DataColumn(
                                      label: SizedBox(
                                          width: devicesize.width * 0.2,
                                          child: const Text(
                                            'VITALS',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ))), // First column
                                  const DataColumn(
                                      label: Text(
                                    '10 JAN 2023',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  )),
                                  const DataColumn(
                                      label: Text('< 10 OCT 2022 >',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black))),
                                ],
                                rows: [
                                  DataRow(
                                    cells: [
                                      DataCell(

                                          customText(
                                          "Blood Pr…", FontWeight.bold,Alignment.centerLeft)), // Data for the first column
                                      DataCell(Container(
                                        //width: 75,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          child:Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child:customText(
                                          '120/89',FontWeight.w400,Alignment.centerRight)))), // Data for the second column
                                      DataCell(
                                        Container(
                                          //width: 75,
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                right: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                            child:Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child:customText(
                                          '120/89',FontWeight.w400,Alignment.centerRight)))), // Data for the third column
                                    ],
                                  ),
                                  DataRow(
                                    cells: [
                                      DataCell(customText("Glucose",FontWeight.bold,Alignment.centerLeft)),
                                      DataCell(Container(
                                        //width: 75,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          child:Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child:customText('97',FontWeight.w400,Alignment.centerRight)))),
                                      DataCell(Container(
                                        //width: 75,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          child:Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child:customText('97',FontWeight.w400,Alignment.centerRight)))),
                                    ],
                                  ),
                                  DataRow(
                                    cells: [
                                      DataCell(customText(
                                          "Heart Ra…",FontWeight.bold,Alignment.centerLeft)), // Data for the first column
                                      DataCell(Container(
                                        //width: 75,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          child:Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child:customText(
                                          '108',FontWeight.w400,Alignment.centerRight)))), // Data for the second column
                                      DataCell(Container(
                                        //width: 75,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          child:Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child:customText(
                                          '108',FontWeight.w400,Alignment.centerRight)))), // Data for the third column
                                    ],
                                  ),
                                  DataRow(
                                    cells: [
                                      DataCell(customText(
                                          "LDL Chol…",FontWeight.bold,Alignment.centerLeft)), // Data for the first column
                                      DataCell(Container(
                                        //width: 75,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          child:Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child:customText(
                                          'Value',FontWeight.w400,Alignment.centerRight)))), // Data for the second column
                                      DataCell(Container(
                                        //width: 75,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          child:Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child:customText(
                                          'Value',FontWeight.w400,Alignment.centerRight)))), // Data for the third column
                                    ],
                                  ),
                                  DataRow(
                                    cells: [
                                      DataCell(customText(
                                          "HDL Chol…",FontWeight.bold,Alignment.centerLeft)), // Data for the first column
                                      DataCell(Container(
                                        //width: 75,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          child:Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child:customText(
                                          'Value',FontWeight.w400,Alignment.centerRight)))), // Data for the second column
                                      DataCell(Container(
                                        //width: 75,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          child:Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child:customText(
                                          'Value',FontWeight.w400,Alignment.centerRight)))), // Data for the third column
                                    ],
                                  ),
                                  DataRow(
                                    cells: [
                                      DataCell(customText(
                                          "Blood Pr…",FontWeight.bold,Alignment.centerLeft)), // Data for the first column
                                      DataCell(Container(
                                        //width: 75,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          child:Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child:customText(
                                          'Value',FontWeight.w400,Alignment.centerRight)))), // Data for the second column
                                      DataCell(Container(
                                        //width: 75,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          child:Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child:customText(
                                          'Value',FontWeight.w400,Alignment.centerRight)))), // Data for the third column
                                    ],
                                  ),
                                  DataRow(
                                    cells: [
                                      DataCell(customText(
                                          "Creatinine",FontWeight.bold,Alignment.centerLeft)), // Data for the first column
                                      DataCell(Container(
                                        //width: 75,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          child:Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child:customText(
                                          'Value',FontWeight.w400,Alignment.centerRight)))), // Data for the second column
                                      DataCell(Container(
                                        //width: 75,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          child:Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child:customText(
                                          'Value',FontWeight.w400,Alignment.centerRight)))), // Data for the third column
                                    ],
                                  ),
                                  DataRow(
                                    cells: [
                                      DataCell(customText(
                                          "Vitals #7",FontWeight.bold, Alignment.centerLeft)), // Data for the first column
                                      DataCell(Container(
                                        //width: 75,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          child:
                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:customText(
                                          'Value', FontWeight.w400, Alignment.centerRight)))), // Data for the second column
                                      DataCell(
                                        Container(
                                          //width: 75,
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                right: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                            child:
                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:customText(
                                          'Value',FontWeight.w400,Alignment.centerRight)))), // Data for the third column
                                    ],
                                  ),
                                ]),
                          ),
                        ),
                        textHeadingWithItem(
                          "CHIEF COMPLAINT",
                          const Text(
                            'DRY COUGH WITH CHEST CONGESTION, SOB\n'
                            'FEVER X 12 DAYS H/O DRY COUGH RECURRENT\n'
                            'WITH CHANGE OF SEASON NO COMORBIDITIES',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ),
                        textHeadingWithItem(
                          "EXAMINATION",
                          const Text(
                            'LOREM IPSUM DOLOR SIT AMET, CONSECTETUR\n'
                            'ADIPISCING ELIT, SED DO EIUSMOD TEMPOR\n'
                            'INCIDIDUNT UT LABORE',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        textHeadingWithItem(
                          "INVESTIGATION",
                          const Text(
                            '+ 1 RT-PCR COVID-19 VIRUS\n'
                            'RNANASOPHARYNGEL OROPHARYNGEL SWAB\n\n'
                            '+ 1 COMPLETE BLOOD COUNT (CBC)',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        textHeadingWithItem(
                          "PROVISIONAL DIAGNOSIS",
                          const Text(
                            'ALLERGIC COUGH VARIANT ASTHMA WITH VIRAL\n'
                            'EXACERBATION COVID RT PCR NEGATIVE ON 17 SEP',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child:
                        SvgPicture.asset(ImagesConstants.prescriptionDrawer)),
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                DataTable(
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => ColorKonstants.bloodpressureBG2),
                    border: TableBorder.all(width: 1, color: Colors.black45),
                    columns: const [
                      DataColumn(
                          label: SizedBox(
                              width: 100,
                              child: Text(
                                'MEDICINE NAME',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ))),
                    ],
                    rows: getAllPrescriptionData!.medicines!
                        .map((medicine) => DataRow(
                              cells: [
                                DataCell(
                                  SizedBox(
                                      width: 100,
                                    child: Text(medicine.medicineName ??
                                      "FORACORT 1 REPSULES 2 ML",maxLines: 2,),
                                  )),
                              ],
                            ))
                        .toList()),
                Expanded(
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: _scrollController,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => ColorKonstants.bloodpressureBG2),
                          border:
                              TableBorder.all(width: 1, color: Colors.black45),
                          columns: const [
                            // First column
                            DataColumn(
                                label: Text(
                              'DOSE',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )),
                            DataColumn(
                                label: Text('TIMES',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black))),
                            DataColumn(
                                label: Text('DURN.',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black))),
                            DataColumn(
                                label: Text('MEAL',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black))),
                            DataColumn(
                                label: Text('ROUTE',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black))),
                            DataColumn(
                                label: Text('QTY',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black))),
                            DataColumn(
                                label: Text('REMARKS',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black))),
                          ],
                          rows: getAllPrescriptionData.medicines!
                              .map(
                                (medicine) => DataRow(cells: [
                                  DataCell(Text(
                                      '${medicine.dose ?? 1} ${medicine.doseUnit}')),
                                  DataCell(Text(medicine.times ?? 'IBD')),
                                  DataCell(Text(
                                      '${medicine.duration} ${medicine.doseUnit}')),
                                  DataCell(Text(medicine.meal ?? 'Before Meal')),
                                  DataCell(Text(medicine.route ?? 'Inhalation')),
                                  DataCell(Text(medicine.quantity.toString())),
                                  DataCell(Text(
                                      medicine.comments ?? 'Some Comment Here')),
                                ]),
                              )
                              .toList()),
                    ),
                  ),
                ),
              ]),
              const SizedBox(
                height: 25,
              ),
              buildRichText(originalText),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'This consultation is based on the input provided by the patient via online medium. "no physical examination has been performed and all pati advised to visit a doctor for any complications." this opinion cannot be challenged for any medico-legal requirements as agreed upon in terms a conditions on registration."this is a digital copy and it doesnt require physical signature.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: const [
                  Text(
                    "DOCUMENT DIGITALLY SIGNED BY",
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(doctorDetails?.userData?.name ?? "Dr. Aditi Sharma"),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: const [
                  Text("MCI# GOES HERE"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textHeading(String title) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(title,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey)),
      ),
    );
  }

  Widget customText(String text, FontWeight weight, Alignment align) {
    return Align(
      alignment: align,
      child: Text(text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 15, fontWeight: weight, color: Colors.black)),
    );
  }

  Widget textHeadingWithItem(String heading, Widget widget) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [textHeading(heading), widget],
      ),
    );
  }
}

enum VitalCondition { normal, aboveNormal, belowNormal }
