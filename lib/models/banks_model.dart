import 'package:mahesabu/db/database_provider.dart';
import 'package:sqflite/sqflite.dart';

class BanksModel {
  int id;
  double crdb;
  double nmb;
  double equity;
  double nbc;
  double tpb;
  double access;
  double azania;
  String date;

  BanksModel(
      {this.id,
      this.crdb,
      this.nmb,
      this.equity,
      this.nbc,
      this.tpb,
      this.access,
      this.azania,
      this.date});

  double total() {
    double sum = this.crdb +
        this.nmb +
        this.equity +
        this.nbc +
        this.tpb +
        this.access +
        this.azania;
    return sum;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.columnCRDB: crdb,
      DatabaseProvider.columnNMB: nmb,
      DatabaseProvider.columnEQUITY: equity,
      DatabaseProvider.columnNBC: nbc,
      DatabaseProvider.columnTPB: tpb,
      DatabaseProvider.columnACCESS: access,
      DatabaseProvider.columnAZANIA: azania,
      DatabaseProvider.columnBanksDate: date,
    };

    if (id != null) {
      map[DatabaseProvider.columnBankID] = id;
    }
    return map;
  }

  BanksModel.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.columnBankID];
    crdb = map[DatabaseProvider.columnCRDB];
    nmb = map[DatabaseProvider.columnNMB];
    equity = map[DatabaseProvider.columnEQUITY];
    nbc = map[DatabaseProvider.columnNBC];
    tpb = map[DatabaseProvider.columnTPB];
    access = map[DatabaseProvider.columnACCESS];
    azania = map[DatabaseProvider.columnAZANIA];
    date = map[DatabaseProvider.columnBanksDate];
  }

  Future<List<BanksModel>> getBanks() async {
    final db = await DatabaseProvider.db.database;

    var banks = await db.query(DatabaseProvider.banksTable,
        columns: [
          DatabaseProvider.columnBankID,
          DatabaseProvider.columnCRDB,
          DatabaseProvider.columnNMB,
          DatabaseProvider.columnEQUITY,
          DatabaseProvider.columnNBC,
          DatabaseProvider.columnTPB,
          DatabaseProvider.columnACCESS,
          DatabaseProvider.columnAZANIA,
          DatabaseProvider.columnBanksDate,
        ],
        orderBy: '-${DatabaseProvider.columnBankID}');

    List<BanksModel> bankList = List<BanksModel>();

    banks.forEach((currentBank) {
      BanksModel bank = BanksModel.fromMap(currentBank);
      bankList.add(bank);
    });
    return bankList;
  }

  Future<BanksModel> getBank({int id}) async {
    final db = await DatabaseProvider.db.database;

    var banks = await db.query(
      DatabaseProvider.banksTable,
      columns: [
        DatabaseProvider.columnBankID,
        DatabaseProvider.columnCRDB,
        DatabaseProvider.columnNMB,
        DatabaseProvider.columnEQUITY,
        DatabaseProvider.columnNBC,
        DatabaseProvider.columnTPB,
        DatabaseProvider.columnACCESS,
        DatabaseProvider.columnAZANIA,
        DatabaseProvider.columnBanksDate,
      ],
      where: "${DatabaseProvider.columnBankID}=?",
      whereArgs: [id],
    );

    BanksModel bankList = BanksModel();

    banks.forEach((currentBank) {
      BanksModel bank = BanksModel.fromMap(currentBank);
      bankList=bank;
    });
    return bankList;
  }

  Future<BanksModel> insert(BanksModel bank) async {
    final db = await DatabaseProvider.db.database;
    bank.id = await db.insert(
      DatabaseProvider.banksTable,
      bank.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return bank;
  }
}
