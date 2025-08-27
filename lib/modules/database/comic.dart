import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:mave/modules/modules.dart' show Comic;




class ComicDb{
  static final ComicDb self = ComicDb._init();
  static Database? _databaseConn;


  static const int _comics_limit = 20;
  static const TABLE_NAME = "Comics";

  

  Future<void> addComics(List<Comic> comics) async{
    final db = await connection;
    final batch = db.batch();
    for (var c in comics) 
      batch.insert(
        TABLE_NAME,
        c.toMap(),
      );
    await batch.commit();
  }


  
  Future<List<Comic>> getComicsWithOffset(int page) async{
    final db = await connection;
    final rows = await db.query(
      TABLE_NAME,
      limit  : _comics_limit,
      offset : _comics_limit * page,
      columns: [
        'id'   , 'title', 'url',
        'cover', 'state'
      ] 
    );
    return rows.map((Map<String, dynamic> row) => Comic(
      id   : row['id']    , 
      title: row['title']!,
      cover: row['cover']!, 
      url  : row['url']!,
      state: row['state']!,
    )).toList();
  }


  ComicDb._init();


  Future<Database> get connection async {
    if (_databaseConn != null) return _databaseConn!;
    _databaseConn = await _getDatabase();
    return _databaseConn!;
  }


  Future<Database> _getDatabase() async{
    return await openDatabase(
      join(await getDatabasesPath(), 'comic.db'),
      version: 1,
      onCreate:_createDb,
    );
  }


  Future<void> _createDb(Database db, int version) async{
    await db.execute("""
      CREATE TABLE $TABLE_NAME (
        id    INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT COLLATE NOCASE NOT NULL,
        url   TEXT NOT NULL UNIQUE,
        cover TEXT NOT NULL,
        state INTEGER NOT NULL DEFAULT 0 CHECK(state IN (0, 1, 2))
      )
    """);
  }
}
