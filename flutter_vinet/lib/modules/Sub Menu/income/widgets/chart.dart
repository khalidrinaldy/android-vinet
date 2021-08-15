import 'package:flutter/material.dart';
import 'package:flutter_vinet/widgets/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget chart(List<IncomeDummy> stats) {
  TooltipBehavior? _tooltipBehavior;
  return SfCartesianChart(
    primaryXAxis: CategoryAxis(),
    // Chart title
    //title: ChartTitle(text: 'Half yearly sales analysis'),
    // Enable legend
    //legend: Legend(isVisible: true),
    // Enable tooltip
    tooltipBehavior: _tooltipBehavior,
    series: <LineSeries<IncomeDummy, String>>[
      LineSeries<IncomeDummy, String>(
        dataSource: stats,
        xValueMapper: (IncomeDummy incomeDummy, _) => incomeDummy.month,
        yValueMapper: (IncomeDummy incomeDummy, _) => incomeDummy.income,
        color: Color(myColors.primaryBlue()),
        // Enable data label
        dataLabelSettings: DataLabelSettings(isVisible: false),
      ),
    ],
  );
}

class IncomeDummy {
  final int income;
  final String month;
  IncomeDummy(this.income, this.month);
}
