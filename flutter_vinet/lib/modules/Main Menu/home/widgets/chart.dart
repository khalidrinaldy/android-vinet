import 'package:flutter/material.dart';
import 'package:flutter_vinet/widgets/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget chart(List<ConnectData> stats) {
  TooltipBehavior? _tooltipBehavior;
  return SfCartesianChart(
    primaryXAxis: CategoryAxis(),
    // Chart title
    //title: ChartTitle(text: 'Half yearly sales analysis'),
    // Enable legend
    //legend: Legend(isVisible: true),
    // Enable tooltip
    tooltipBehavior: _tooltipBehavior,
    series: <LineSeries<ConnectData, double>>[
      LineSeries<ConnectData, double>(
        dataSource: stats,
        xValueMapper: (ConnectData connectData, i) => i.toDouble(),
        yValueMapper: (ConnectData connectData, _) => connectData.tx,
        color: Color(myColors.primaryBlue()),
        // Enable data label
        dataLabelSettings: DataLabelSettings(isVisible: false),
      ),
      LineSeries<ConnectData, double>(
        dataSource: stats,
        xValueMapper: (ConnectData connectData, i) => i.toDouble(),
        yValueMapper: (ConnectData connectData, _) => connectData.rx,
        color: Color(myColors.primaryGreen()),
        // Enable data label
        dataLabelSettings: DataLabelSettings(isVisible: false),
      ),
    ],
  );
}

class ConnectData {
  final double tx;
  final double rx;
  ConnectData(this.tx, this.rx);
}
