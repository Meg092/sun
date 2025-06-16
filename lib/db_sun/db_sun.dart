
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sun_record/db_sun/sun_entity.dart';

class DBSun extends GetxService {
  late Database dbBase;

  Future<DBSun> init() async {
    await createSunDB();
    return this;
  }

  createSunDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'sun.db');

    dbBase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await createSunTable(db);
        });
  }

  createSunTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS sun (id INTEGER PRIMARY KEY, createdTime TEXT, title TEXT, type INTEGER, startTime TEXT, endTime TEXT)');
  }

  insertSun(SunEntity entity) async {
    final id = await dbBase.insert('sun', {
      'createdTime': entity.createdTime.toIso8601String(),
      'title': entity.title,
      'type': entity.type,
      'startTime': entity.startTime.toIso8601String(),
      'endTime': entity.endTime.toIso8601String(),
    });
    return id;
  }

  Future<List<SunEntity>> getSunAllData() async {
    var result = await dbBase.query('sun', orderBy: 'createdTime DESC');
    return result.map((e) => SunEntity.fromJson(e)).toList();
  }
}
