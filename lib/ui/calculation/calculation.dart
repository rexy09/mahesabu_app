import 'package:flutter/material.dart';
import './calculation_form.dart';

class CalculationPage extends StatefulWidget {
  CalculationPage({Key key}) : super(key: key);

  @override
  _CalculationPageState createState() => _CalculationPageState();
}

class _CalculationPageState extends State<CalculationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculate'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              CalcutationForm(),
            ]
          ),
        ),
      ),
    );
  }
}
