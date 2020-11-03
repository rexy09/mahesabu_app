import 'package:mahesabu/db/database_provider.dart';
import 'package:sqflite/sqflite.dart';

class CashModel {
   int id;
   double amount;
   String date;

   CashModel({this.id,this.amount, this.date});

   double total() {
    double total = this.amount;
    return total;
  }

   Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.columnCash: amount,
      DatabaseProvider.columnCashDate: date,
    };

    if (id != null) {
      map[DatabaseProvider.columnCashID] = id;
    }
    return map;
  }

  CashModel.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.columnCashID];
    amount = map[DatabaseProvider.columnCash];
    date = map[DatabaseProvider.columnCashDate];
  }

  Future<List<CashModel>> getCashs() async {
    final db = await DatabaseProvider.db.database;

    var cashs = await db.query(DatabaseProvider.cashTable,
        columns: [
          DatabaseProvider.columnCashID,
          DatabaseProvider.columnCash,
          DatabaseProvider.columnCashDate,
        ],
        orderBy: '-${DatabaseProvider.columnCashID}');

    List<CashModel> cashList = List<CashModel>();

    cashs.forEach((currentCash) {
      CashModel cash = CashModel.fromMap(currentCash);
      cashList.add(cash);
    });
    return cashList;
  }

  Future <CashModel> getCash({int id}) async {
    final db = await DatabaseProvider.db.database;

    var cashs = await db.query(DatabaseProvider.cashTable,
        columns: [
          DatabaseProvider.columnCashID,
          DatabaseProvider.columnCash,
          DatabaseProvider.columnCashDate,
        ],
        where: '${DatabaseProvider.columnCashID}=?',
        whereArgs: [id],
        );

    CashModel cashList = CashModel();

    cashs.forEach((currentCash) {
      CashModel cash = CashModel.fromMap(currentCash);
      cashList=cash;
    });
    return cashList;
  }

  Future<CashModel> insert(CashModel cash) async {
    final db = await DatabaseProvider.db.database;
    cash.id = await db.insert(
      DatabaseProvider.cashTable,
      cash.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return cash;
  }

}