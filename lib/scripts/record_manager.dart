import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// sql 语句
class _Constants {
  /// 数据库名
  static const String dBName = 'record.db';

  /// 表名
  static const String tableName = 'record';

  /// sql: 获取全部表名
  static const String sqlGetAllTableNames =
      'SELECT name FROM sqlite_master WHERE type = "table"';

  /// sql: 创建 Record 表
  static const String sqlCreateRecordTable = '''
    CREATE TABLE IF NOT EXISTS $tableName (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
      isIncome INTEGER NOT NULL,
      amount REAL NOT NULL,
      desc TEXT(100),
      timestamp INTEGER NOT NULL
    );
  ''';

  /// sql: 删除 Record 表
  static const String sqlDropRecordTable = '''DROP TABLE record;''';
}

/// 数据库控制类
class RecordManager {
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

  /// 检查数据库是否已打开 (未打开则打印错误信息)
  static Future<bool> _checkIfAvailable({
    String desc = '自检',
    bool autoOpen = false,
  }) async {
    if (!isOpen()) {
      print('[$desc] 数据库未连接!');

      if (autoOpen) {
        await init();
        return true;
      }

      return false;
    }

    return true;
  }

  /// 初始化数据库 (连接 + 自动创建数据库)
  static Future<void> init() async {
    String dbPath = await getDatabasesPath();
    String dbFile = join(dbPath, _Constants.dBName);
    try {
      _db ??= await openDatabase(dbFile);
      List<String> tables = await getValidTableNames();
      if (tables.contains(_Constants.tableName)) {
        print('[初始化] 数据表 <${_Constants.tableName}> 已存在!');
      } else {
        _db
            ?.execute(_Constants.sqlCreateRecordTable)
            .then((v) => print('[初始化] 创建表完成!'));
      }
    } catch (e) {
      print('[初始化] 初始化数据库出错! $e');
    }
  }

  /// 获取全部的表名 (去除 'android_metadata'、'sqlite_sequence' 等自动创建表)
  static Future<List<String>> getValidTableNames() async {
    bool available = await _checkIfAvailable(desc: '查询');

    if (available) {
      List<String> validTableNames = [];
      List<Map<String, Object?>> tables =
          await _db!.rawQuery(_Constants.sqlGetAllTableNames);

      tables.forEach((element) {
        String tableName = element['name'].toString();
        if (!tableName.contains('metadata') && !tableName.contains('sqlite')) {
          validTableNames.add(element['name'].toString());
        }
      });

      return validTableNames;
    }

    return [];
  }

  /// 插入数据
  static Future<bool> insert({
    required bool isIncome,
    required double amount,
    String? desc,
    int? timestamp,
  }) async {
    bool available = await _checkIfAvailable(desc: '插入', autoOpen: true);

    if (available) {
      try {
        await _db?.insert(_Constants.tableName, {
          "isIncome": isIncome ? 1 : 0,
          "amount": amount,
          "desc": desc ?? "",
          "timestamp": DateTime.now().millisecondsSinceEpoch
        });
        return true;
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  /// todo 删除数据 返回删除的条目数
  static Future<int> delete() async {
    bool available = await _checkIfAvailable(desc: '删除');

    if (available) {}

    return 0;
  }

  /// todo 查询数据
  static Future<void> query() async {
    bool available = await _checkIfAvailable(desc: '查询', autoOpen: true);

    if (available) {
      _db?.query(_Constants.tableName).then((value) {
        print("data in db: $value");
      });
    }
  }

  /// todo 更新数据
  static Future<void> update() async {
    bool available = await _checkIfAvailable(desc: '更新');

    if (available) {}
  }

  /// 清空数据表 - 返回删除的条目数
  static Future<int> clear() async {
    bool available = await _checkIfAvailable(desc: '清空');

    if (available) {
      int count = await _db!.delete('record');
      // print('[清空]: 删除了$count条数据');
      return count;
    }
    return 0;
  }

  /// 删除数据表 - 全表删除
  static Future<bool> drop(String tableName) async {
    bool available = await _checkIfAvailable(desc: '删表');

    if (available) {
      _db
          ?.execute(_Constants.sqlDropRecordTable)
          .then((v) => print('[删除表] 删除表完成!'))
          .catchError((err) {
        print("[删除表] 删除表出错! $err");
      });

      _db?.close();
      _db = null;

      return true;
    }

    return false;
  }

  /// 关闭数据库连接
  static Future<void> dispose() async {
    bool available = await _checkIfAvailable(desc: '关闭');

    if (available) {
      _db?.close();
      _db = null;
    }
  }
}

// class RecordManager {
//   // 获取某一天的总计
//   static Future<double> getDaySum(DateTime day) async {
//     return Random().nextDouble() * 100;
//   }
//
//   // 获取某月的总计
//   static Future<double> getMonthSum(int month) async {
//     return Random().nextDouble() * 100;
//   }
//
//   // 获取某年的总计
//   static Future<double> getYearSum(int year) async {
//     return Random().nextDouble() * 100;
//   }
//
//   // 获取某一天的详情
//   static Future<List> getTodayDetail(DateTime day) async {
//     return [];
//   }
// }
