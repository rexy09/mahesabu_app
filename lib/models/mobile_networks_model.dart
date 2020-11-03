import 'package:mahesabu/db/database_provider.dart';
import 'package:sqflite/sqflite.dart';

class MobileNetworksModel {
  int id;
  double mpesa;
  double tigopesa;
  double airtelmoney;
  double halopesa;
  double tpesa;
  double ezypesa;
  String date;

  MobileNetworksModel({this.id, this.mpesa, this.tigopesa, this.airtelmoney, this.halopesa, this.tpesa, this.ezypesa, this.date});

  double total(){
    double sum = this.mpesa + this.tigopesa + this.airtelmoney + this.halopesa + this.tpesa + this.ezypesa;
    return sum;
  }

    Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.columnMpesa: mpesa,
      DatabaseProvider.columnTigoPesa: tigopesa,
      DatabaseProvider.columnAirtelMoney: airtelmoney,
      DatabaseProvider.columnHaloPesa: halopesa,
      DatabaseProvider.columnTpesa: tpesa,
      DatabaseProvider.columnEzyPesa: ezypesa,
      DatabaseProvider.columnMobileNetworkDate: date,
    };

    if (id != null) {
      map[DatabaseProvider.columnMobileNetworkID] = id;
    }
    return map;
  }

  MobileNetworksModel.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.columnMobileNetworkID];
    mpesa = map[DatabaseProvider.columnMpesa];
    tigopesa = map[DatabaseProvider.columnTigoPesa];
    airtelmoney = map[DatabaseProvider.columnAirtelMoney];
    halopesa = map[DatabaseProvider.columnHaloPesa];
    tpesa = map[DatabaseProvider.columnTpesa];
    ezypesa = map[DatabaseProvider.columnEzyPesa];
    date = map[DatabaseProvider.columnMobileNetworkDate];
  }

  Future<List<MobileNetworksModel>> getMobileNetworks() async {
    final db = await DatabaseProvider.db.database;

    var mobileNetworks = await db.query(DatabaseProvider.mobileNetworksTable,
        columns: [
          DatabaseProvider.columnMobileNetworkID,
          DatabaseProvider.columnMpesa,
          DatabaseProvider.columnTigoPesa,
          DatabaseProvider.columnAirtelMoney,
          DatabaseProvider.columnHaloPesa,
          DatabaseProvider.columnTpesa,
          DatabaseProvider.columnEzyPesa,
          DatabaseProvider.columnMobileNetworkDate,
        ],
        orderBy: '-${DatabaseProvider.columnMobileNetworkID}');

    List<MobileNetworksModel> mobileNetworkList = List<MobileNetworksModel>();

    mobileNetworks.forEach((currentMobileNetwork) {
      MobileNetworksModel mobileNetwork = MobileNetworksModel.fromMap(currentMobileNetwork);
      mobileNetworkList.add(mobileNetwork);
    });
    return mobileNetworkList;
  }

  Future<MobileNetworksModel> getMobileNetwork({int id}) async {
    final db = await DatabaseProvider.db.database;

    var mobileNetworks = await db.query(DatabaseProvider.mobileNetworksTable,
        columns: [
          DatabaseProvider.columnMobileNetworkID,
          DatabaseProvider.columnMpesa,
          DatabaseProvider.columnTigoPesa,
          DatabaseProvider.columnAirtelMoney,
          DatabaseProvider.columnHaloPesa,
          DatabaseProvider.columnTpesa,
          DatabaseProvider.columnEzyPesa,
          DatabaseProvider.columnMobileNetworkDate,
        ],
        where: '${DatabaseProvider.columnMobileNetworkID}=?',
        whereArgs: [id],
        );

    MobileNetworksModel mobileNetworkList = MobileNetworksModel();

    mobileNetworks.forEach((currentMobileNetwork) {
      MobileNetworksModel mobileNetwork = MobileNetworksModel.fromMap(currentMobileNetwork);
      mobileNetworkList=mobileNetwork;
    });
    return mobileNetworkList;
  }  

  Future<MobileNetworksModel> insert(MobileNetworksModel mobileNetwork) async {
    final db = await DatabaseProvider.db.database;
    mobileNetwork.id = await db.insert(
      DatabaseProvider.mobileNetworksTable,
      mobileNetwork.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return mobileNetwork;
  }
  
}