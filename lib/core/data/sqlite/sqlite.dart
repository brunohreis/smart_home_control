import 'dart:async';
import 'package:smart_home_control/core/data/models/device_model.dart';
import 'package:smart_home_control/core/data/models/esp_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';


class SQLiteHelper{
  static Future<Database> getDatabase() async{
    /*
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
    */
    final dbsPath = await getDatabasesPath();
    final dbPath = join(dbsPath, 'my_app_db.db');
    final returnDb = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        String query = "CREATE TABLE Esps "
            "(id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "name TEXT, "
            "mac TEXT);"
        ;
        db.execute(query);
        query = "CREATE TABLE Devices "
            "(id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "name TEXT, "
            "type_index INTEGER, "
            "id_esp INTEGER, "
            "FOREIGN KEY (id_esp) REFERENCES Esps (id));"
        ;
        db.execute(query);
      },
    );
    //print("db opened: " + returnDb.isOpen.toString());
    return returnDb;
  }
  static Future<int> createEsp(EspModel esp) async {
    Database db = await getDatabase();
    Map<String, dynamic> data = {
      'name': esp.name,
      'mac': esp.mac,
    };
    int id = await db.insert("Esps", data);
    //print("Esp salva com id: $id");
    return id;
  }
  static Future<List<EspModel>> readAllEsps() async {
    List<EspModel> esps = List.empty(growable: true);
    Database db = await getDatabase();
    List<Map<String, dynamic>> espsAux = await db.query("Esps", columns: ["*"]);
    for(var esp in espsAux){
      esps.add(EspModel.fromMap(esp));
    }
    return esps;
  }
  static Future<EspModel> readEsp(int id) async {
    Database db = await getDatabase();
    var aux = await db.query("Esps", columns: ["*"], where: "id = ?", whereArgs: [id]);
    return EspModel.fromMap(aux[0]);
  }
  static updateEsp(EspModel esp) async {
    Database db = await getDatabase();
    int rows = await db.update("Esps", esp.toMap(), where: "id = ?", whereArgs: [esp.id]);
    //print("Deleted $rows rows");
  }
  static deleteEsp(int id) async {
    Database db = await getDatabase();
    int rows = await db.delete("Esps", where: "id = ?", whereArgs: [id]);
    //print("Deleted $rows rows");
  }


}