import 'package:sqflite/sqflite.dart';
import '../db/database_provider.dart';

class TotalModel {
  int id;
  double amount;
  String date;

  TotalModel({this.id, this.amount, this.date});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.columnAmount: amount,
      DatabaseProvider.columnTotalDate: date,
    };

    if (id != null) {
      map[DatabaseProvider.columnTotalID] = id;
    }
    return map;
  }

  Map<String, dynamic> toMapUpdate() {
    var map = <String, dynamic>{
      DatabaseProvider.columnAmount: amount,
    };
    return map;
  }

  TotalModel.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.columnTotalID];
    amount = map[DatabaseProvider.columnAmount];
    date = map[DatabaseProvider.columnTotalDate];
  }

  Future<List<TotalModel>> getTotal() async {
    final db = await DatabaseProvider.db.database;

    var totals = await db.query(
      DatabaseProvider.totalTable,
      columns: [
        DatabaseProvider.columnTotalID,
        DatabaseProvider.columnAmount,
        DatabaseProvider.columnTotalDate
      ],
      orderBy: '-${DatabaseProvider.columnTotalID}'
    );

    List<TotalModel> totalList = List<TotalModel>();

    totals.forEach((currentTotal) {
      TotalModel total = TotalModel.fromMap(currentTotal);
      totalList.add(total);
    });
    return totalList;
  }

  Future<TotalModel> insert(TotalModel total) async {
    final db = await DatabaseProvider.db.database;
    total.id = await db.insert(
      DatabaseProvider.totalTable,
      total.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return total;
  }

  Future<int> delete(int id) async {
    final db = await DatabaseProvider.db.database;
    return await db.delete(
      DatabaseProvider.totalTable,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(TotalModel total) async {
    final db = await DatabaseProvider.db.database;
    return await db.update(
      DatabaseProvider.totalTable,
      total.toMapUpdate(),
      where: "id = ?",
      whereArgs: [total.id],
    );
  }
}
