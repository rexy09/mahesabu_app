import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  // Total Table
  static const String totalTable = "total";
  static const String columnTotalID = "id";
  static const String columnAmount = "amount";
  static const String columnTotalDate = "date";

  // Mobile Network Table
  static const String mobileNetworksTable = "mobile_networks";
  static const String columnMobileNetworkID = "mobile_network_id";
  static const String columnMpesa = "mpesa";
  static const String columnTigoPesa = "tigopesa";
  static const String columnAirtelMoney = "airtelmoney";
  static const String columnHaloPesa = "halopesa";
  static const String columnTpesa = "tpesa";
  static const String columnEzyPesa = "ezypesa";
  static const String columnMobileNetworkDate = "date";

  // Banks Table
  static const String banksTable = "banks";
  static const String columnBankID = "bank_id";
  static const String columnCRDB = "crdb";
  static const String columnNMB = "nmb";
  static const String columnEQUITY = "equity";
  static const String columnNBC = "nbc";
  static const String columnTPB = "tpb";
  static const String columnACCESS = "access";
  static const String columnAZANIA = "azania";
  static const String columnBanksDate = "date";

  // Payment Agent Table
  static const String paymentAgentTable = "payment_agents";
  static const String columnPaymentAgentID = "payment_agent_id";
  static const String columnSelcom = "selcom";
  static const String columnPaymentAgentDate = "date";

  // Debts Table
  static const String debtsTable = "debts";
  static const String columnDebtID = "debt_id";
  static const String columnDebt = "debt";
  static const String columnDebtDate = "date";

  // Debts Table
  static const String cashTable = "cash_book";
  static const String columnCashID = "cash_id";
  static const String columnCash = "cash";
  static const String columnCashDate = "date";

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  createDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    // join(directory.path, 'mahesabuDB.db')
    return await openDatabase(
      '${directory.path}mahesabuDB.db',
      version: 1,
      onCreate: (Database database, int version) async {
        await database.execute(
          "CREATE TABLE $totalTable ("
          "$columnTotalID INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,"
          "$columnAmount REAL,"
          "$columnTotalDate DATETIME"
          ")",
        );
        await database.execute(
          "CREATE TABLE $mobileNetworksTable ("
          "$columnMobileNetworkID INTERGER PRIMARY KEY UNIQUE NOT NULL,"
          "$columnMpesa REAL,"
          "$columnTigoPesa REAL,"
          "$columnAirtelMoney REAL,"
          "$columnHaloPesa REAL,"
          "$columnTpesa REAL,"
          "$columnEzyPesa REAL,"
          "$columnMobileNetworkDate DATETIME DEFAULT CURRENT_TIMESTAMP,"
          "FOREIGN KEY ($columnMobileNetworkID) REFERENCES $totalTable ($columnTotalID) ON DELETE CASCADE"
          ")",
        );
        await database.execute(
          "CREATE TABLE $banksTable ("
          "$columnBankID INTERGER PRIMARY KEY UNIQUE NOT NULL,"
          "$columnCRDB REAL,"
          "$columnNMB REAL,"
          "$columnEQUITY REAL,"
          "$columnNBC REAL,"
          "$columnTPB REAL,"
          "$columnACCESS REAL,"
          "$columnAZANIA REAL,"
          "$columnBanksDate DATETIME DEFAULT CURRENT_TIMESTAMP,"
          "FOREIGN KEY ($columnBankID) REFERENCES $totalTable ($columnTotalID) ON DELETE CASCADE"
          ")",
        );
        await database.execute(
          "CREATE TABLE $paymentAgentTable ("
          "$columnPaymentAgentID INTERGER PRIMARY KEY UNIQUE NOT NULL,"
          "$columnSelcom REAL,"
          "$columnPaymentAgentDate DATETIME DEFAULT CURRENT_TIMESTAMP,"
          "FOREIGN KEY ($columnPaymentAgentID) REFERENCES $totalTable ($columnTotalID) ON DELETE CASCADE"
          ")",
        );
        await database.execute(
          "CREATE TABLE $debtsTable ("
          "$columnDebtID INTERGER PRIMARY KEY UNIQUE NOT NULL,"
          "$columnDebt REAL,"
          "$columnDebtDate DATETIME DEFAULT CURRENT_TIMESTAMP,"
          "FOREIGN KEY ($columnDebtID) REFERENCES $totalTable ($columnTotalID) ON DELETE CASCADE"
          ")",
        );
        await database.execute(
          "CREATE TABLE $cashTable ("
          "$columnCashID INTERGER PRIMARY KEY UNIQUE NOT NULL,"
          "$columnCash REAL,"
          "$columnCashDate DATETIME DEFAULT CURRENT_TIMESTAMP,"
          "FOREIGN KEY ($columnCashID) REFERENCES $totalTable ($columnTotalID) ON DELETE CASCADE"
          ")",
        );
      },
      onConfigure: _onConfigure,
    );
  }

  Future _onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  
}
