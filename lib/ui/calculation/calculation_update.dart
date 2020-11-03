import 'package:flutter/material.dart';
import '../../models/total_model.dart';

// ignore: must_be_immutable
class CalculationUpdate extends StatefulWidget {
  TotalModel total;

  CalculationUpdate({Key key, @required this.total}) : super(key: key);

  @override
  _CalculationUpdateState createState() => _CalculationUpdateState();
}

class _CalculationUpdateState extends State<CalculationUpdate> {
  final _formKey = GlobalKey<FormState>();
  double _amount;

  _inputValidatation(value) {
    if (value.isEmpty) {
      return 'Please enter number or Default value 0';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculate Update'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      initialValue: '${widget.total.amount}',
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Total cash',
                      ),
                      validator: (value) => _inputValidatation(value),
                      onSaved: (value) {
                        // assigning value to the variable
                        _amount = double.parse(value);
                      },
                    ),
                  ),
                  RaisedButton(
                    child: Text('Update'),
                    textColor: Colors.white,
                    color: Colors.purple,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        
                        TotalModel totalData = TotalModel(id: widget.total.id, amount: _amount);
                        TotalModel().update(totalData).then((value) {
                          Navigator.pop(context);
                        });
                      }
                    },
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
