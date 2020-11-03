import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../models/mobile_networks_model.dart';
import '../../models/banks_model.dart';
import '../../models/total_model.dart';
import '../../models/payment_agents_model.dart';
import '../../models/debts_model.dart';
import '../../models/cash_model.dart';

class CalcutationForm extends StatefulWidget {
  @override
  _CalcutationFormState createState() => _CalcutationFormState();
}

class _CalcutationFormState extends State<CalcutationForm> {
  final _formKey = GlobalKey<FormState>();

  var prefs;
  double total = 0;
  var mobileNetworks;
  var banks;
  var paymentAgents;
  var debt;
  var cash;
  // Mobile Networks Controller
  final myCash = TextEditingController();
  final mPesa = TextEditingController();
  final tigoPesa = TextEditingController();
  final airtelMoney = TextEditingController();
  final haloPesa = TextEditingController();
  final tPesa = TextEditingController();
  final ezyPesa = TextEditingController();
  // Banks Controller
  final crdbBank = TextEditingController();
  final nmbBank = TextEditingController();
  final equityBank = TextEditingController();
  final nbcBank = TextEditingController();
  final tpbBank = TextEditingController();
  final accessBank = TextEditingController();
  final azaniaBank = TextEditingController();
  // Debts Controller
  final debts = TextEditingController();
  final selcom = TextEditingController();

  final Map<String, String> allPreferences = {
    'mpesa': 'M-Pesa',
    'tigopesa': 'Tigo Pesa',
    'airtelmoney': 'Airtel Money',
    'halopesa': 'Halo Pesa',
    'tpesa': 'T-Pesa',
    'ezypesa': 'EzyPesa',
    'crdb': 'CRDB Bank',
    'nmb': 'NMB Bank',
    'equity': 'EQUITY Bank',
    'nbc': 'NBC Bank',
    'tpb': 'TPB Bank',
    'access': 'Access Bank',
    'azania': 'Azania Bank',
    'selcom': 'Selcom',
  };

  // Future method to get preference
  Future<void> _getPreference() async {
    final object = await SharedPreferences.getInstance();
    setState(() {
      this.prefs = object;
    });
  }

  Widget _textField(
      {String preference, TextEditingController controller, Map allPrefs}) {
    return this.prefs.getBool(preference) == true
        ? Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter ${allPrefs[preference]} float',
              ),
              validator: (value) => _inputValidatation(value),
            ),
          )
        : Container();
  }

  _inputValidatation(value) {
    if (value.isEmpty) {
      return 'Please enter number or Default value 0';
    }
    return null;
  }

  void _totalSum(
      {double cash, double mobile, double banks, double selcom, double debts}) {
    setState(() {
      this.total = cash + mobile + banks + selcom + debts;
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Total Amount",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          content: Text(
            "${this.total}",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Save",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
              onPressed: () {
                TotalModel totalData =
                    TotalModel(amount: this.total, date: '${DateTime.now()}');
                TotalModel().insert(totalData).then((totalData) {
                  this.banks.id = totalData.id;
                  this.banks.date = totalData.date;
                  BanksModel().insert(this.banks).then((value) {
                    print(value);
                  });

                  this.mobileNetworks.id = totalData.id;
                  this.mobileNetworks.date = totalData.date;
                  MobileNetworksModel()
                      .insert(this.mobileNetworks)
                      .then((value) {
                    print(value);
                  });

                  this.paymentAgents.id = totalData.id;
                  this.paymentAgents.date = totalData.date;
                  PaymentAgentsModel().insert(this.paymentAgents).then((value) {
                    print(value);
                  });

                  this.debt.id = totalData.id;
                  this.debt.date = totalData.date;
                  DebtsModel().insert(this.debt).then((value) {
                    print(value);
                  });

                  this.cash.id = totalData.id;
                  this.cash.date = totalData.date;
                  CashModel().insert(this.cash).then((value) {
                    print(value);
                  });
                });
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text(
                "Close",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // Getting preferene
    _getPreference();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: this.prefs != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  heightFactor: 2,
                  child: Text(
                    '${this.total}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: myCash,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Total cash',
                    ),
                    validator: (value) => _inputValidatation(value),
                  ),
                ),
                // Mobile Networks Fields
                _textField(
                  preference: 'mpesa',
                  controller: mPesa,
                  allPrefs: allPreferences,
                ),
                _textField(
                  preference: 'tigopesa',
                  controller: tigoPesa,
                  allPrefs: allPreferences,
                ),
                _textField(
                  preference: 'airtelmoney',
                  controller: airtelMoney,
                  allPrefs: allPreferences,
                ),
                _textField(
                  preference: 'halopesa',
                  controller: haloPesa,
                  allPrefs: allPreferences,
                ),
                _textField(
                  preference: 'tpesa',
                  controller: tPesa,
                  allPrefs: allPreferences,
                ),
                _textField(
                  preference: 'ezypesa',
                  controller: ezyPesa,
                  allPrefs: allPreferences,
                ),
                // Bank Fields
                _textField(
                  preference: 'crdb',
                  controller: crdbBank,
                  allPrefs: allPreferences,
                ),
                _textField(
                  preference: 'nmb',
                  controller: nmbBank,
                  allPrefs: allPreferences,
                ),
                _textField(
                  preference: 'equity',
                  controller: equityBank,
                  allPrefs: allPreferences,
                ),
                _textField(
                  preference: 'nbc',
                  controller: nbcBank,
                  allPrefs: allPreferences,
                ),
                _textField(
                  preference: 'tpb',
                  controller: tpbBank,
                  allPrefs: allPreferences,
                ),
                _textField(
                  preference: 'access',
                  controller: accessBank,
                  allPrefs: allPreferences,
                ),
                _textField(
                  preference: 'azania',
                  controller: azaniaBank,
                  allPrefs: allPreferences,
                ),
                _textField(
                  preference: 'selcom',
                  controller: selcom,
                  allPrefs: allPreferences,
                ),
                this.prefs.getBool('debts') == true
                    ? Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: TextFormField(
                          controller: debts,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter Debts ',
                          ),
                          validator: (value) => _inputValidatation(value),
                        ),
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      child: Text(
                        'Total',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      color: Colors.purple,
                      onPressed: () {
                        // Validate returns true if the form is valid, or false

                        if (_formKey.currentState.validate()) {
                          mobileNetworks = MobileNetworksModel(
                            mpesa: double.parse(
                                (mPesa.text.isEmpty) ? '0' : mPesa.text),
                            tigopesa: double.parse(
                                (tigoPesa.text.isEmpty) ? '0' : tigoPesa.text),
                            airtelmoney: double.parse((airtelMoney.text.isEmpty)
                                ? '0'
                                : airtelMoney.text),
                            halopesa: double.parse(
                                (haloPesa.text.isEmpty) ? '0' : haloPesa.text),
                            tpesa: double.parse(
                                (tPesa.text.isEmpty) ? '0' : tPesa.text),
                            ezypesa: double.parse(
                                (ezyPesa.text.isEmpty) ? '0' : ezyPesa.text),
                          );

                          banks = BanksModel(
                            crdb: double.parse(
                                (crdbBank.text.isEmpty) ? '0' : crdbBank.text),
                            nmb: double.parse(
                                (nmbBank.text.isEmpty) ? '0' : nmbBank.text),
                            equity: double.parse((equityBank.text.isEmpty)
                                ? '0'
                                : equityBank.text),
                            nbc: double.parse(
                                (nbcBank.text.isEmpty) ? '0' : nbcBank.text),
                            tpb: double.parse(
                                (tpbBank.text.isEmpty) ? '0' : tpbBank.text),
                            access: double.parse((accessBank.text.isEmpty)
                                ? '0'
                                : accessBank.text),
                            azania: double.parse((azaniaBank.text.isEmpty)
                                ? '0'
                                : azaniaBank.text),
                          );

                          paymentAgents = PaymentAgentsModel(
                            selcom: double.parse(
                                (selcom.text.isEmpty) ? '0' : selcom.text),
                          );

                          debt = DebtsModel(
                            amount: double.parse(
                                (debts.text.isEmpty) ? '0' : debts.text),
                          );

                          cash = CashModel(
                            amount: double.parse(
                                (myCash.text.isEmpty) ? '0' : myCash.text),
                          );

                          _totalSum(
                            cash: cash.total(),
                            mobile: mobileNetworks.total(),
                            banks: banks.total(),
                            selcom: paymentAgents.total(),
                            debts: debt.total(),
                          );

                          _showDialog();
                        }
                      },
                    ),
                  ),
                ),
              ],
            )
          : LoadingOverlay(child: Container(), isLoading: false),
    );
  }
}
