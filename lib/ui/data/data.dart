import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
// import 'package:intl/intl.dart';
import '../../models/total_model.dart';
import '../calculation/calculation_update.dart';
import '../data/data_details.dart';

class DataPage extends StatefulWidget {
  DataPage({Key key}) : super(key: key);

  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> with AfterLayoutMixin<DataPage> {
  List<TotalModel> cards = [];

  // var newFormat = DateFormat("yy-MM-dd");

  Widget _getLoadingCard() {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          ListTile(
            title: Text(
              '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            subtitle: Text(
              '',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  void _showDialog({total}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Actions",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // RaisedButton(
              //   child: Text('Update'),
              //   textColor: Colors.white,
              //   color: Colors.blue,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.all(Radius.circular(20)),
              //   ),
              //   onPressed: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => CalculationUpdate(total: total),
              //         ));
              //   },
              // ),
              RaisedButton(
                child: Text('Delete'),
                textColor: Colors.white,
                color: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                onPressed: () {
                  TotalModel().delete(total.id).then((value) {
                    _cardList();
                    Navigator.pop(context);
                  });
                },
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
                textColor: Colors.white,
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _amountFormat(double amount) {
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: amount);
    return fmf.output.nonSymbol;
  }

  Widget getCard({total}) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        // color: Color.fromRGBO(167, 38, 148, 1),
        // gradient: LinearGradient(
        //   colors: [
        //     Color.fromRGBO(167, 38, 148, 1),
        //     Color.fromRGBO(183, 42, 162, 1),
        //     Color.fromRGBO(199, 46, 176, 1),
        //   ],
        // ),
        // boxShadow: [
        //   BoxShadow(
        //     color: Color.fromRGBO(183, 42, 162, 0.3),
        //     spreadRadius: 1,
        //     blurRadius: 5,
        //     offset: Offset(0, 3),
        //   ),
        // ],
        border: Border.all(color:Colors.grey[300],width: 2),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          ListTile(
            title: Text(
              'TZS ${_amountFormat(total.amount)}/= ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              '${total.date}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
            leading: Icon(
              Icons.payments,
              color: Colors.amberAccent,
            ),
            onLongPress: () => _showDialog(total: total),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DataDetailsPage(
                      total: total,
                    ),
                  ));
            },
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Future<void> _cardList() async {
    TotalModel().getTotal().then((totalList) {
      // Getting list of total from database
      setState(() {
        this.cards = totalList;
      });
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    _cardList();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: Align(
              heightFactor: 1,
              alignment: Alignment.centerLeft,
              child: Text(
                'Daily Balances',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 28,
                    color: Color.fromRGBO(23, 5, 21, 1)),
              ),
            ),
          ),
         Divider(
            indent: 10,
            endIndent: 10,
          ),
          Column(
            children: this.cards.isNotEmpty
                ? List.generate(
                    this.cards.length,
                    (index) => getCard(
                      total: this.cards[index],
                    ),
                  )
                : List.generate(
                    5,
                    (index) => _getLoadingCard(),
                  ),
          ),
        ],
      ),
    );
  }
}
