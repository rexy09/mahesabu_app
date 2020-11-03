import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mahesabu/models/total_model.dart';

class StackedAreaLineChart extends StatelessWidget {
  // final List<LinearSales> data;
  final List<TotalModel> data;
  final bool animate;

  StackedAreaLineChart(this.data, {this.animate});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<TotalModel, int>> series = [
      charts.Series<TotalModel, int>(
        id: 'Total',
        data: data,
        domainFn: (TotalModel sales, _) => sales.id,
        measureFn: (TotalModel sales, _) => sales.amount,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      ),
    ];
    return Container(
        height: 400,
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: charts.LineChart(series,
                  defaultRenderer: charts.LineRendererConfig(
                    includeArea: true,
                    stacked: true,
                  ),
                  animate: animate),
            )
          ],
        ));
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
