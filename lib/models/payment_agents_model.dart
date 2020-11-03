import 'package:mahesabu/db/database_provider.dart';
import 'package:sqflite/sqflite.dart';

class PaymentAgentsModel {
  int id;
  double selcom;
  String date;

  PaymentAgentsModel({this.id, this.selcom, this.date});

  double total() {
    double total = this.selcom;
    return total;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.columnSelcom: selcom,
      DatabaseProvider.columnPaymentAgentDate: date,
    };

    if (id != null) {
      map[DatabaseProvider.columnPaymentAgentID] = id;
    }
    return map;
  }

  PaymentAgentsModel.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.columnPaymentAgentID];
    selcom = map[DatabaseProvider.columnSelcom];
    date = map[DatabaseProvider.columnPaymentAgentDate];
  }

  Future<List<PaymentAgentsModel>> getPaymentAgents() async {
    final db = await DatabaseProvider.db.database;

    var paymentAgents = await db.query(DatabaseProvider.paymentAgentTable,
        columns: [
          DatabaseProvider.columnPaymentAgentID,
          DatabaseProvider.columnSelcom,
          DatabaseProvider.columnPaymentAgentDate,
        ],
        orderBy: '-${DatabaseProvider.columnPaymentAgentID}');

    List<PaymentAgentsModel> paymentAgentList = List<PaymentAgentsModel>();

    paymentAgents.forEach((currentPaymentAgent) {
      PaymentAgentsModel paymentAgent =
          PaymentAgentsModel.fromMap(currentPaymentAgent);
      paymentAgentList.add(paymentAgent);
    });
    return paymentAgentList;
  }

  Future<PaymentAgentsModel> getPaymentAgent({int id}) async {
    final db = await DatabaseProvider.db.database;

    var paymentAgents = await db.query(
      DatabaseProvider.paymentAgentTable,
      columns: [
        DatabaseProvider.columnPaymentAgentID,
        DatabaseProvider.columnSelcom,
        DatabaseProvider.columnPaymentAgentDate,
      ],
      where: '${DatabaseProvider.columnPaymentAgentID}=?',
      whereArgs: [id],
    );

    PaymentAgentsModel paymentAgentList = PaymentAgentsModel();

    paymentAgents.forEach((currentPaymentAgent) {
      PaymentAgentsModel paymentAgent =
          PaymentAgentsModel.fromMap(currentPaymentAgent);
      paymentAgentList=paymentAgent;
    });
    return paymentAgentList;
  }

  Future<PaymentAgentsModel> insert(PaymentAgentsModel paymentAgent) async {
    final db = await DatabaseProvider.db.database;
    paymentAgent.id = await db.insert(
      DatabaseProvider.paymentAgentTable,
      paymentAgent.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return paymentAgent;
  }
}
