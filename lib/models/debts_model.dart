import 'package:mahesabu/db/database_provider.dart';
import 'package:sqflite/sqflite.dart';

class DebtsModel {
   int id;
   double amount;
   String date;

   DebtsModel({this.id,this.amount, this.date});

   double total() {
    double total = this.amount;
    return total;
  }

   Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.columnDebt: amount,
      DatabaseProvider.columnDebtDate: date,
    };

    if (id != null) {
      map[DatabaseProvider.columnDebtID] = id;
    }
    return map;
  }

  DebtsModel.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.columnDebtID];
    amount = map[DatabaseProvider.columnDebt];
    date = map[DatabaseProvider.columnDebtDate];
  }

  Future<List<DebtsModel>> getDebts() async {
    final db = await DatabaseProvider.db.database;

    var debts = await db.query(DatabaseProvider.debtsTable,
        columns: [
          DatabaseProvider.columnDebtID,
          DatabaseProvider.columnDebt,
          DatabaseProvider.columnDebtDate,
        ],
        orderBy: '-${DatabaseProvider.columnDebtID}');

    List<DebtsModel> debtList = List<DebtsModel>();

    debts.forEach((currentDebt) {
      DebtsModel debt = DebtsModel.fromMap(currentDebt);
      debtList.add(debt);
    });
    return debtList;
  }

  Future<DebtsModel> getDebt({int id}) async {
    final db = await DatabaseProvider.db.database;

    var debts = await db.query(DatabaseProvider.debtsTable,
        columns: [
          DatabaseProvider.columnDebtID,
          DatabaseProvider.columnDebt,
          DatabaseProvider.columnDebtDate,
        ],
        where: '${DatabaseProvider.columnDebtID}=?',
        whereArgs: [id],
        );

    DebtsModel debtList = DebtsModel();

    debts.forEach((currentDebt) {
      DebtsModel debt = DebtsModel.fromMap(currentDebt);
      debtList=debt;
    });
    return debtList;
  }

  Future<DebtsModel> insert(DebtsModel debt) async {
    final db = await DatabaseProvider.db.database;
    debt.id = await db.insert(
      DatabaseProvider.debtsTable,
      debt.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return debt;
  }

}