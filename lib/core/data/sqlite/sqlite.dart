import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:smart_home_control/core/data/models/device_model.dart';
import 'package:smart_home_control/core/data/models/esp_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';


class SQLiteHelper{
  static Future<Database> getDatabase() async{
    if (kIsWeb) {
      // Use web implementation on the web.
      databaseFactory = databaseFactoryFfiWeb;
    } else {
      // Use ffi on Linux and Windows.
      if (Platform.isLinux || Platform.isWindows) {
        databaseFactory = databaseFactoryFfi;
        sqfliteFfiInit();
      }
    }
    databaseFactory = databaseFactoryFfi;
    final dbsPath = await getDatabasesPath();
    final dbPath = join(dbsPath, 'banco.db');
    final returnDb = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        String query = "CREATE TABLE esps "
            "(id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "name STRING, "
            "mac STRING)"
            "CREATE TABLE devices "
            "(id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "name STRING, "
            "type_index INT"
            "id_esp INT"
            "FOREIGN KEY (esp_id) REFERENCES esps (id_esp)"
        ;
        db.execute(query);
      },
    );
    print("db opened: " + returnDb.isOpen.toString());
    return returnDb;
  }
  static Future<int> createEsp(EspModel esp) async {
    Database db = await getDatabase();
    Map<String, dynamic> data = {
      'name': esp.name,
      'mac': esp.mac,
    };
    int id = await db.insert("esps", data);
    print("Esp salva com id: $id");
    return id;
  }
  static Future<List<EspModel>> readAllEsps() async {
    List<EspModel> esps = List.empty();
    Database db = await getDatabase();
    List<Map<String, dynamic>> espsAux = db.query("esps", columns: ["*"]) as List<Map<String, dynamic>>;
    for(var esp in espsAux){
      esps.add(EspModel.fromMap(esp));
    }
    return esps;
  }
  static Future<EspModel> readEsp(int id) async {
    Database db = await getDatabase();
    var aux = db.query("esps", columns: ["*"], where: "id = ?", whereArgs: [id]) as List<Map<String, dynamic>>;
    return EspModel.fromMap(aux[0]);
  }
  static updateEsp(EspModel esp) async {
    Database db = await getDatabase();
    db.update("esps", esp.toMap(), where: "where id = ?", whereArgs: [esp.id]);
  }
  static deleteEsp(int id) async {
    Database db = await getDatabase();
    db.delete("esps", where: "where id = ?", whereArgs: [id]);
  }


}