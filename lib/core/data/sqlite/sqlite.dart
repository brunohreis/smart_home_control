import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper{
  dynamic db;
  SQLiteHelper(){
    db = buildDatabase();
  }
  Future<Database> buildDatabase() async{
    final dbsPath = await getDatabasesPath();
    final dbPath = join(dbsPath, 'banco.db');
    final returnDb = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        String query = "CREATE TABLE esps "
            "(id_esp INTEGER PRIMARY KEY AUTOINCREMENT, "
            "name STRING, "
            "mac STRING)"
            "CREATE TABLE devices "
            "(id_device INTEGER PRIMARY KEY AUTOINCREMENT, "
            "name STRING, "
            "type_index INT"
            "id_esp INT"
            "FOREIGN KEY (esp_id) REFERENCES esps (id_esp)"
        ;
        db.execute(query);
      },
    );
    print("db opened: " + db.isOpen.toString());
    return returnDb;
  }
  createEsp(String mac, String name){
    Map<String, dynamic> data = {
      name: name,
      mac: mac,
    };
    int id = bd.insert("")
    db.insert()
  }
}