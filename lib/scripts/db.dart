import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wohuaqianlema/scripts/range.dart';
import 'package:wohuaqianlema/scripts/utils.dart';

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

  /// 查询全部数据表语句
  static const sqlTableNames =
      'SELECT name FROM sqlite_master WHERE type = "table"';

  /// 删表语句 record
  static const String sqlDropTableRecord = "DROP TABLE IF EXISTS record;";

  /// 删表语句 tag
  static const String sqlDropTableTag = "DROP TABLE IF EXISTS tag;";
}

/// sqlite 自增表查看
class _DBMeta {
  /// 表名 - 安卓元数据
  static const tableNameMeta = 'android_metadata';

  /// 表名 - 自增表
  static const tableNameSeq = 'sqlite_sequence';

  /// 查询安卓元数据表
  static Future<List<Map<String, Object?>>> queryMeta(Database db) async {
    try {
      return await db.query(tableNameMeta);
    } catch (err) {
      safePrint(err, condition: '安卓元数据表查询');
      return [];
    }
  }

  /// 查询自增表
  static Future<List<Map<String, Object?>>> querySeq(Database db) async {
    try {
      return await db.query(tableNameSeq);
    } catch (err) {
      safePrint(err, condition: '自增表查询');
      return [];
    }
  }

  /// 重置标签自增 <br/>
  /// `tableName` 的值为 `_DBTag.tableName` 或 `_DBRecord.tableName` <br/>
  static Future<bool> resetSeq(Database db, String tableName) async {
    assert(tableName == _DBTag.tableName || tableName == _DBRecord.tableName);

    try {
      db.update(tableNameSeq, {"seq": 0}, where: 'name = "$tableName"');
      return true;
    } catch (err) {
      safePrint(err, condition: '重置自增表');
      return false;
    }
  }
}

class _DBTag {
  /// 表名
  static const tableName = 'tag';

  /// 新增标签
  static Future<bool> insert(Database db, String tagName) async {
    try {
      await db.insert(tableName, {"name": tagName});
      return true;
    } catch (err) {
      safePrint(err, condition: '新增标签');
      return false;
    }
  }

  /// 删除标签
  static Future<bool> delete(Database db, int tagId) async {
    try {
      await db.delete(tableName, where: 'id = $tagId');
      return true;
    } catch (err) {
      safePrint(err, condition: '删除标签');
      return false;
    }
  }

  /// **@description** 查询 全部/目标 标签名 <br/>
  /// **@param** id 目标id <br/>
  /// **@param** nameLike 目标标签名(模糊查询) <br/>
  /// **@return** Array<{id: number, name: string}> <br/>
  static Future<List<Map<String, Object?>>> query(
    Database db, {
    int? tagId,
    String? nameLike,
  }) async {
    assert(tagId == null || nameLike == null);

    String? where;
    if (tagId != null) {
      where = 'id = $tagId';
    } else if (nameLike != null) {
      where = 'name like "%$nameLike%"';
    }

    try {
      return await db.query(tableName, where: where);
    } catch (err) {
      safePrint(err, condition: '查询标签');
      return [];
    }
  }

  /// **@description** 更新 目标标签名
  /// **@param** id 目标id <br/>
  /// **@param** newName 新标签名 <br/>
  static Future<bool> update(Database db, int tagId, String newName) async {
    try {
      await db.update(tableName, {'name': newName}, where: 'id = $tagId');
      return true;
    } catch (err) {
      safePrint(err, condition: '更新标签');
      return false;
    }
  }

  /// 清空标签并重置自增为0
  static Future<bool> clear(Database db) async {
    try {
      await db.delete(tableName);
      bool resetResult = await _DBMeta.resetSeq(db, tableName);
      if (!resetResult) safePrint('重置出错', condition: '重置标签自增');

      return true;
    } catch (err) {
      safePrint(err, condition: '清空标签');
      return false;
    }
  }
}

class _DBRecord {
  /// 表名
  static const tableName = 'record';

  /// 新增记录
  static Future<bool> insert(
    Database db, {
    required int isIncome,
    required double amount,
    String? desc,
    required int timestamp,
    int? tagId,
  }) async {
    try {
      await db.insert(tableName, {
        "isIncome": isIncome,
        "amount": amount,
        "desc": desc,
        "timestamp": timestamp,
        "tagId": tagId,
      });
      return true;
    } catch (err) {
      safePrint(err, condition: '新增记录');
      return false;
    }
  }

  /// 删除记录
  static Future<bool> delete(Database db, int recordId) async {
    try {
      await db.delete(tableName, where: 'id = $recordId');
      return true;
    } catch (err) {
      safePrint(err, condition: '删除记录');
      return false;
    }
  }

  /// 查询记录 (详细条件查询)
  static Future<List<Map<String, Object?>>> query(
    Database db, {
    bool? isIncome,
    RangeNumber? amountRange,
    String? descLike,
    RangeDate? dateRange,
    int? tagId,
  }) async {
    List<String> conditions = [];

    if (isIncome != null) conditions.add('isIncome = ${isIncome ? 1 : 0}');
    if (amountRange != null &&
        (amountRange.min != null || amountRange.max != null)) {
      if (amountRange.max == null) {
        conditions.add('amount >= ${amountRange.min}');
      } else if (amountRange.min == null) {
        conditions.add('amount <= ${amountRange.max}');
      } else {
        conditions
            .add('amount between ${amountRange.min} and ${amountRange.max}');
      }
    }
    if (descLike != null) conditions.add('desc like "%$descLike%"');
    if (dateRange != null && (dateRange.min != null || dateRange.max != null)) {
      if (dateRange.max == null) {
        conditions.add('timestamp >= ${dateRange.min!.millisecondsSinceEpoch}');
      } else if (dateRange.min == null) {
        conditions.add('timestamp <= ${dateRange.max!.millisecondsSinceEpoch}');
      } else {
        conditions.add(
            'timestamp between ${dateRange.min!.millisecondsSinceEpoch} and ${dateRange.max!.millisecondsSinceEpoch}');
      }
    }
    if (tagId != null) conditions.add('tagId = $tagId');

    try {
      return await db.query(tableName,
          where: conditions.isEmpty ? null : conditions.join(' AND '));
    } catch (err) {
      safePrint(err, condition: '查询记录');
      return [];
    }
  }

  /// 更新记录
  /// todo
  static Future<bool> update(Database db, int tagId, String newName) async {
    try {
      await db.update(tableName, {'name': newName}, where: 'id = $tagId');
      return true;
    } catch (err) {
      safePrint(err, condition: '更新标签');
      return false;
    }
  }

  /// 清空记录并重置自增为0
  static Future<bool> clear(Database db) async {
    try {
      await db.delete(tableName);
      bool resetResult = await _DBMeta.resetSeq(db, tableName);
      if (!resetResult) safePrint('重置出错', condition: '重置记录自增');

      return true;
    } catch (err) {
      safePrint(err, condition: '清空记录');
      return false;
    }
  }
}

/// 数据库控制
class DBController {
  /// 数据库对象
  static Database? _db;

  /// 数据库是否连接
  static bool get isConnect {
    return _db == null;
  }

  /// 数据库是否打开(未打开则返回`false`)
  static bool get isOpen {
    return _db?.isOpen ?? false;
  }

  /// 初始化数据库
  static Future<bool> _initDB() async {
    // 若已经打开数据库则直接返回
    if (isOpen) return true;

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
    if (!isOpen) return false;
    try {
      for (String sql in _DBConstants.sqlCreateTable) {
        await _db?.execute(sql);
      }
      return true;
    } catch (err) {
      safePrint(err, condition: '初始化数据表');
      return false;
    }
  }

  /// 初始化
  static Future<bool> init() async {
    try {
      bool dbResult = await _initDB();
      bool tableResult = await _initTables();
      if (dbResult && tableResult) {
        safePrint('数据库初始化并连接', condition: '初始化');
        return true;
      } else {
        safePrint('DB: $dbResult ;Tables: $tableResult}', condition: '初始化');
        return false;
      }
    } catch (err) {
      safePrint(err, condition: '初始化');
      return false;
    }
  }

  /// 自检, 若未初始化则(默认)先初始化数据库
  static Future<bool> _prelude({bool autoInit = true}) async {
    if (!isOpen) {
      safePrint('数据库未连接', condition: '自检');
      if (autoInit) {
        return await init();
      }
    }
    return true;
  }

  /// 新增标签
  static Future<bool> addTag(String tagName) async {
    assert(tagName.length < 10);

    if (!await _prelude()) return false;
    assert(_db != null);

    return await _DBTag.insert(_db!, tagName);
  }

  /// 删除标签
  static Future<bool> deleteTag(int tagId) async {
    if (!await _prelude()) return false;
    assert(_db != null);

    return await _DBTag.delete(_db!, tagId);
  }

  /// 查询标签
  static Future<List<Map<String, Object?>>> queryTag({
    int? tagId,
    String? nameLike,
  }) async {
    if (!await _prelude()) return [];
    assert(_db != null);

    return await _DBTag.query(_db!, tagId: tagId, nameLike: nameLike);
  }

  /// 修改标签
  static Future<bool> editTag(int tagId, String newName) async {
    if (!await _prelude()) return false;
    assert(_db != null);

    return await _DBTag.update(_db!, tagId, newName);
  }

  /// 清空标签并重置自增为1
  static Future<bool> clearAllTag() async {
    if (!await _prelude()) return false;
    assert(_db != null);

    return await _DBTag.clear(_db!);
  }

  /// 新增记录
  static Future<bool> addRecord({
    required int isIncome,
    required double amount,
    String? desc,
    required int timestamp,
    int? tagId,
  }) async {
    if (!await _prelude()) return false;
    assert(_db != null);

    return await _DBRecord.insert(
      _db!,
      isIncome: isIncome,
      amount: amount,
      desc: desc,
      timestamp: timestamp,
      tagId: tagId,
    );
  }

  /// 删除记录
  static Future<bool> deleteRecord(int recordId) async {
    if (!await _prelude()) return false;
    assert(_db != null);

    return await _DBRecord.delete(_db!, recordId);
  }

  /// 查询记录
  static Future<List<Map<String, Object?>>> queryRecord({
    bool? isIncome,
    RangeNumber? amountRange,
    String? descLike,
    RangeDate? dateRange,
    int? tagId,
  }) async {
    if (!await _prelude()) return [];
    assert(_db != null);

    return await _DBRecord.query(
      _db!,
      isIncome: isIncome,
      amountRange: amountRange,
      descLike: descLike,
      dateRange: dateRange,
      tagId: tagId,
    );
  }

  /// 修改记录
  /// 清空记录并重置自增为1
  static Future<bool> clearAllRecord() async {
    if (!await _prelude()) return false;
    assert(_db != null);

    return await _DBRecord.clear(_db!);
  }

  /// 测试 - 全部表名
  static Future<void> testQueryTableList() async {
    if (_db == null) {
      safePrint('数据库未打开', condition: '测试');
    } else {
      _db!.rawQuery(_DBConstants.sqlTableNames).then((value) {
        List<String> tables = value.map((e) => e['name'] as String).toList();
        safePrint(tables, condition: '全部数据表');
      });
    }
  }

  static Future<void> testQuerySeq() async {
    if (!await _prelude()) return;
    assert(_db != null);

    _DBMeta.querySeq(_db!)
        .then((value) => safePrint(value, condition: '自增表查询'));
  }

  static Future<void> testQueryMeta() async {
    if (!await _prelude()) return;
    assert(_db != null);

    _DBMeta.queryMeta(_db!)
        .then((value) => safePrint(value, condition: '安卓元数据表查询'));
  }
}
