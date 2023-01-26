import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wohuaqianlema/scripts/utils.dart';

enum _TableNames { record, tag }

/// 数据库相关
class _DBConstants {
  /// 数据库文件位置
  static const String fileName = 'record.db';

  /// 建表语句
  static const sqlCreateTable = <String>[
    '''
      CREATE TABLE IF NOT EXISTS record (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
        isIncome INTEGER NOT NULL,
        amount REAL NOT NULL,
        desc TEXT(50),
        timestamp INTEGER NOT NULL,
        tagId INTEGER NOT NULL
      );
    ''',
    '''
      CREATE TABLE IF NOT EXISTS tag (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
        name CHAR(10)
      );
    ''',
  ];

  /// 删表语句 record
  static const String sqlDropTableRecord = "DROP TABLE IF EXISTS record;";

  /// 删表语句 tag
  static const String sqlDropTableTag = "DROP TABLE IF EXISTS tag;";
}

/// 数据库控制
class DBOperator {
  /// 数据库对象
  static Database? _db;

  /// 数据库是否连接
  static bool isConnect() {
    return _db == null;
  }

  /// 数据库是否打开(未连接则返回false)
  static bool isOpen() {
    return _db?.isOpen ?? false;
  }

  /// 初始化数据库
  static Future<bool> _initDB() async {
    // 若已经打开数据库则直接返回
    if (isOpen()) return true;

    // 获取数据库文件位置
    String filePathBase = await getDatabasesPath();
    String filePathFull = join(filePathBase, _DBConstants.fileName);

    try {
      _db = await openDatabase(filePathFull);
      return true;
    } catch (err) {
      safePrint(err, condition: '初始化数据库');
      return false;
    }
  }

  /// 初始化数据表
  static Future<bool> _initTables() async {
    if (!isOpen()) return false;
    try {
      for (String sql in _DBConstants.sqlCreateTable) {
        await _db?.execute(sql);
      }
      return true;
    } catch (err) {
      safePrint(err, condition: '初始化数据表');
    }
    return true;
  }

  /// 初始化
  static Future<bool> init() async {
    try {
      await _initDB();
      await _initTables();
      return true;
    } catch (err) {
      safePrint(err, condition: '初始化');
    }
    return true;
  }

  /// 测试
  /// test
  static Future<void> testQueryTableList() async {
    if (_db == null) {
      print('object');
      safePrint('数据库未打开', condition: '测试');
    } else {
      _db!
          .rawQuery('SELECT name FROM sqlite_master WHERE type = "table"')
          .then((value) => safePrint(value, condition: '全部数据表'));
    }
  }
}
