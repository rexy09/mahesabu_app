import 'package:flutter/material.dart';
import 'package:mahesabu/models/banks_model.dart';
import 'package:mahesabu/models/cash_model.dart';
import 'package:mahesabu/models/debts_model.dart';
import 'package:mahesabu/models/mobile_networks_model.dart';
import 'package:mahesabu/models/payment_agents_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import '../../models/total_model.dart';

// ignore: must_be_immutable
class DataDetailsPage extends StatefulWidget {
  TotalModel total;
  DataDetailsPage({Key key, @required this.total}) : super(key: key);

  @override
  _DataDetailsPageState createState() => _DataDetailsPageState();
}

class _DataDetailsPageState extends State<DataDetailsPage> {
  var prefs;
  var bank;
  var mobile;
  var payment;
  var debt;
  var cash;
  final Map<String, dynamic> allPreferences = {
    'mpesa': ['M-Pesa','assets/img/mpesa-logo.png'],
    'tigopesa': ['Tigo Pesa','assets/img/tigopesa-logo.png'],
    'airtelmoney': ['Airtel Money','assets/img/airtelmoney-logo.jpg'],
    'halopesa': ['Halo Pesa','assets/img/halopesa-logo.png'],
    'tpesa': ['T-Pesa','assets/img/tpesa-logo.jpg'],
    'ezypesa': ['EzyPesa','assets/img/ezypesa-logo.png'],
    'crdb': ['CRDB Bank','assets/img/crdb-logo.png'],
    'nmb': ['NMB Bank','assets/img/nmb-logo.jpg'],
    'equity': ['EQUITY Bank','assets/img/equity-logo.png'],
    'nbc': ['NBC Bank','assets/img/nbc-logo.png'],
    'tpb': ['TPB Bank','assets/img/tpb-logo.jpg'],
    'access': ['Access Bank','assets/img/access-logo.png'],
    'azania': ['Azania Bank','assets/img/azania-logo.png'],
    'selcom': ['Selcom','assets/img/selcom-logo.png'],
    'debts': ['Debts','assets/img/debt-logo.png'],
  };

  // Future method to get preference
  Future<void> _getPreference() async {
    final object = await SharedPreferences.getInstance();
    setState(() {
      this.prefs = object;
    });
  }

  String _amountFormat(double amount) {
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: amount);
    return fmf.output.nonSymbol;
  }

  Widget _getCard({String preference, double amount, Map allPrefs}) {
    return this.prefs.getBool(preference) == true
        ? Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[200],
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: ListTile(             
              title: Text(
                'TZS ${_amountFormat(amount)}/=',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(167, 38, 148, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '${allPrefs[preference][0]}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              trailing: Image.asset(allPrefs[preference][1]),
            ),
          )
        : Container();
  }

  Future<void> _getBank(id) async {
    BanksModel().getBank(id: id).then((value) {
      setState(() {
        bank = value;
      });
    });
  }

  Future<void> _getMobileNetwork(id) async {
    MobileNetworksModel().getMobileNetwork(id: id).then((value) {
      setState(() {
        mobile = value;
      });
    });
  }

  Future<void> _getPayment(id) async {
    PaymentAgentsModel().getPaymentAgent(id: id).then((value) {
      setState(() {
        payment = value;
      });
    });
  }

  Future<void> _getDebt(id) async {
    DebtsModel().getDebt(id: id).then((value) {
      setState(() {
        debt = value;
      });
    });
  }

  Future<void> _getCash(id) async {
    CashModel().getCash(id: id).then((value) {
      setState(() {
        cash = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // Getting preferene
    _getPreference();
    _getBank(widget.total.id);
    _getMobileNetwork(widget.total.id);
    _getPayment(widget.total.id);
    _getDebt(widget.total.id);
    _getCash(widget.total.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Details'),
        backgroundColor: Color.fromRGBO(151, 35, 133, 1),
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: this.cash != null &&
                    this.mobile != null &&
                    this.bank != null &&
                    this.payment != null &&
                    this.debt != null &&
                    this.prefs != null
                ? [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(167, 38, 148, 1),
                      ),
                      child: Center(
                        child: Text(
                          'TZS ${_amountFormat(widget.total.amount)}/=',
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[200],
                            spreadRadius: 0,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          'TZS ${_amountFormat(cash.amount)}/=',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(167, 38, 148, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Cash',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        trailing: Icon(
                          Icons.payments,
                          color: Colors.amberAccent,
                          size: 50,
                        ),
                      ),
                    ),
                    _getCard(
                      preference: 'mpesa',
                      amount: mobile.mpesa,
                      allPrefs: allPreferences,
                    ),
                    _getCard(
                      preference: 'tigopesa',
                      amount: mobile.tigopesa,
                      allPrefs: allPreferences,
                    ),
                    _getCard(
                      preference: 'airtelmoney',
                      amount: mobile.airtelmoney,
                      allPrefs: allPreferences,
                    ),
                    _getCard(
                      preference: 'halopesa',
                      amount: mobile.halopesa,
                      allPrefs: allPreferences,
                    ),
                    _getCard(
                      preference: 'tpesa',
                      amount: mobile.tpesa,
                      allPrefs: allPreferences,
                    ),
                    _getCard(
                      preference: 'ezypesa',
                      amount: mobile.ezypesa,
                      allPrefs: allPreferences,
                    ),
                    _getCard(
                      preference: 'crdb',
                      amount: bank.crdb,
                      allPrefs: allPreferences,
                    ),
                    _getCard(
                      preference: 'nmb',
                      amount: bank.nmb,
                      allPrefs: allPreferences,
                    ),
                    _getCard(
                      preference: 'equity',
                      amount: bank.equity,
                      allPrefs: allPreferences,
                    ),
                    _getCard(
                      preference: 'nbc',
                      amount: bank.nbc,
                      allPrefs: allPreferences,
                    ),
                    _getCard(
                      preference: 'tpb',
                      amount: bank.tpb,
                      allPrefs: allPreferences,
                    ),
                    _getCard(
                      preference: 'access',
                      amount: bank.access,
                      allPrefs: allPreferences,
                    ),
                    _getCard(
                      preference: 'azania',
                      amount: bank.azania,
                      allPrefs: allPreferences,
                    ),
                    _getCard(
                      preference: 'selcom',
                      amount: payment.selcom,
                      allPrefs: allPreferences,
                    ),
                    _getCard(
                      preference: 'debts',
                      amount: debt.amount,
                      allPrefs: allPreferences,
                    )
                  ]
                : [],
          ),
        ),
      ),
    );
  }
}
