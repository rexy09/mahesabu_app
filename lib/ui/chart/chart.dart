import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mahesabu/models/total_model.dart';
import 'package:after_layout/after_layout.dart';
import 'package:mahesabu/ui/chart/line_chart.dart';

class ChartPage extends StatefulWidget {
  ChartPage({Key key}) : super(key: key);

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage>
    with AfterLayoutMixin<ChartPage> {
  List<TotalModel> total = [];
  Future<void> _totalList() async {
    TotalModel().getTotal().then((totalList) {
      // Getting list of total from database
      setState(() {
        this.total = totalList;
      });
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    _totalList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text(
              'Business Trend',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 28,
                color: Color.fromRGBO(23, 5, 21, 1),
              ),
            ),
          ),
          Divider(
            indent: 10,
            endIndent: 10,
          ),
          this.total.isNotEmpty
              ? StackedAreaLineChart(total, animate: true)
              : Container(),
        ],
      ),
    );
  }
}
