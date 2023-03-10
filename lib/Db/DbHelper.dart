import 'package:local_storage_app_theme/modals/task.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{
  static Database? _db;
  static const int _version = 1;
  static const String _dbName = "tasks.db";
  static const String _tableName = "tasks";

  static Future<void> initDB() async{
    if(_db != null){
      return;
    }
    else{
      try{
       String _path = await getDatabasesPath() + _dbName;
       _db = await openDatabase(_path,version: _version,onCreate: (db,version) async{
         print(":::DB CREATED:::");
         await db.execute("CREATE TABLE $_tableName ("
             "id INTEGER PRIMARY KEY AUTOINCREMENT,"
             "title STRING,"
             "note TEXT,"
             "date STRING,"
             "startTime STRING,"
             "endTime STRING,"
             "remind INTEGER,"
             "repeat STRING,"
             "color INTEGER,"
             "isCompleted INTEGER"
             ")");
         print(":::TABLE CREATED:::");
       });
      }catch(e){
        print("<::ERROR::> $e");
      }
    }
  }

  static Future<int> insert(Tasks? tasks) async {
    print(".::INSERT FUNCTION CALLED::.");
    return await _db?.insert(_tableName, tasks!.toJson()) ?? 1 ;
  }

  static Future<List<Map<String,dynamic>>> queryAll() async {
    print(".::QUERY ALL FUNCTION CALLED::.");
    return await _db?.query(_tableName) ?? [];
  }

  static deleteTask(Tasks tasks) async {
   return await _db!.delete(_tableName,where: "id = ?",whereArgs: [tasks.id]);
  }

  static updateStatus(int id) async{
    return await _db!.rawUpdate(
      '''
      UPDATE $_tableName
      SET isCompleted = ?
      WHERE id = ?
      ''',
      [1,id]
    );
  }
}