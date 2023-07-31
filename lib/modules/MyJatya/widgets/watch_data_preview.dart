import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WatchDataPreviewUI extends StatefulWidget {
  final Map data;
  final bool isDialog;

  const WatchDataPreviewUI({
    super.key,
    required this.data,
    this.isDialog = true,
  });

  @override
  State<WatchDataPreviewUI> createState() => _WatchDataPreviewUIState();
}

class _WatchDataPreviewUIState extends State<WatchDataPreviewUI> {
  final List<ChartData> chartData1 = [
    ChartData(2010, 35),
    ChartData(2011, 13),
    ChartData(2012, 34),
    ChartData(2013, 27),
    ChartData(2014, 40)
  ];

  Widget buildGraphView() {
    return Column(
      children: [
         Row(
          children: const [
            Icon(
              Icons.watch,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Your synced smartwatch data.',
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        GraphView(
          title: 'BLOOD PRESSURE',
          subTitle: getLevelTitle(
              widget.data['data']['isBloodPressureNormal'].toString()),
          value:
              '${widget.data['data']['latestBloodPressureSystolic'] ?? ''}/${widget.data['data']['latestBloodPressureDistolic'] ?? ''}',
          unit: 'mm/hg',
          subTitleColor: getSubTitleColor(
              widget.data['data']['isBloodPressureNormal'].toString()),
          color: Colors.orangeAccent,
          data: (widget.data['data']['data'] as List<dynamic>)
              .map(
                (value) => ChartData(
                  DateTime.parse(value['date']!).millisecondsSinceEpoch,
                  (value['bloodPressureSystolic'] ?? 0).toDouble(),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 18),
        GraphView(
          title: 'BLOOD GLUCOSE',
          subTitle: getLevelTitle(
              widget.data['data']['isBloodGlucoseNormal'].toString()),
          value: (widget.data['data']['latestBloodGlucose'] ?? '').toString(),
          unit: 'mg/dl',
          subTitleColor: getSubTitleColor(
              widget.data['data']['isBloodGlucoseNormal'].toString()),
          color: Colors.blue,
          data: (widget.data['data']['data'] as List<dynamic>)
              .map(
                (value) => ChartData(
                  DateTime.parse(value['date']!).millisecondsSinceEpoch,
                  (value['bloodGlucoseValue'] ?? 0).toDouble(),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 18),
        GraphView(
          title: 'HEART RATE',
          subTitle: getLevelTitle(
              widget.data['data']['isHeartRateNormal'].toString()),
          value: (widget.data['data']['latestHeartRate'] ?? '').toString(),
          unit: 'beats per min',
          color: Colors.red,
          subTitleColor: getSubTitleColor(
              widget.data['data']['isHeartRateNormal'].toString()),
          data: (widget.data['data']['data'] as List<dynamic>)
              .map(
                (value) => ChartData(
                  DateTime.parse(value['date']!).millisecondsSinceEpoch,
                  (value['heartRateValue'] ?? 0).toDouble(),
                ),
              )
              .toList(),
        ),
        if (widget.isDialog) const SizedBox(height: 18),
        if (widget.isDialog)
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: const BorderSide(
                  width: 1.0,
                  color: Colors.blue,
                ),
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "OKAY",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isDialog) {
      return AlertDialog(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 22),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: SingleChildScrollView(
            child: buildGraphView(),
          ),
        ),
      );
    } else {
      return buildGraphView();
    }
  }

  String getLevelTitle(String string) {
    if (string == 'normal') {
      return 'In the Norm';
    }
    if (string == 'low') {
      return 'Below the Norm';
    }
    if (string == 'high') {
      return 'Above the Norm';
    }
    return '--';
  }

  Color getSubTitleColor(String string) {
    if (string == 'normal') {
      return Colors.blue;
    }
    if (string == 'low') {
      return Colors.red;
    }
    if (string == 'high') {
      return Colors.red;
    }
    return Colors.black;
  }
}

class GraphView extends StatelessWidget {
  const GraphView({
    super.key,
    required this.data,
    required this.title,
    required this.subTitle,
    required this.unit,
    required this.value,
    this.color = Colors.orangeAccent,
    this.height = 150,
    this.subTitleColor,
  });

  final List<ChartData> data;
  final Color color;
  final Color? subTitleColor;
  final double height;
  final String title;
  final String value;
  final String unit;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: color.withOpacity(0.4),
          width: 1,
        ),
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        subTitle,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: subTitleColor ?? Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' $unit',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SfCartesianChart(
              series: <ChartSeries>[
                SplineSeries<ChartData, num>(
                  dataSource: data,
                  splineType: SplineType.monotonic,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  color: color,
                ),
              ],
              primaryXAxis: CategoryAxis(
                isVisible: false,
              ),
              primaryYAxis: CategoryAxis(
                isVisible: false,
              ),
              plotAreaBorderWidth: 0,
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final num y;
}
