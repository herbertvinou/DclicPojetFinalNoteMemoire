import 'package:sqflite/sqflite.dart';

import '../database/database_constants.dart';
import '../database/database_helper.dart';

class Repository {

  Repository._();

  static final Repository instance = Repository._();

  Future<Database> get database async {

    return await DatabaseHelper.instance.database;

  }

  //==========================
  // INSERT
  //==========================

  Future<int> insert(

      String table,

      Map<String, dynamic> values,

      ) async {

    final db = await database;

    return await db.insert(
      table,
      values,
    );

  }

  //==========================
  // SELECT ALL
  //==========================

  Future<List<Map<String, dynamic>>> findAll(

      String table,

      ) async {

    final db = await database;

    return await db.query(table);

  }

  //==========================
  // SELECT BY ID
  //==========================

  Future<Map<String, dynamic>?> findById(

      String table,

      String idColumn,

      int id,

      ) async {

    final db = await database;

    final result = await db.query(

      table,

      where: "$idColumn = ?",

      whereArgs: [id],

      limit: 1,

    );

    if (result.isEmpty) {

      return null;

    }

    return result.first;

  }

  //==========================
  // UPDATE
  //==========================

  Future<int> update(

      String table,

      Map<String, dynamic> values,

      String idColumn,

      int id,

      ) async {

    final db = await database;

    return await db.update(

      table,

      values,

      where: "$idColumn = ?",

      whereArgs: [id],

    );

  }

  //==========================
  // DELETE
  //==========================

  Future<int> delete(

      String table,

      String idColumn,

      int id,

      ) async {

    final db = await database;

    return await db.delete(

      table,

      where: "$idColumn = ?",

      whereArgs: [id],

    );

  }

  //==========================
// SELECT WHERE
//==========================

  Future<List<Map<String, dynamic>>> findWhere(

      String table,

      String where,

      List<dynamic> whereArgs,

      ) async {

    final db = await database;

    return await db.query(

      table,

      where: where,

      whereArgs: whereArgs,

    );

  }


  //==================================================
// SELECT ONE
// Retourne un seul enregistrement ou null
//==================================================

  Future<Map<String, dynamic>?> findOne(

      String table,

      String where,

      List<dynamic> whereArgs,

      ) async {

    final db = await database;

    final result = await db.query(

      table,

      where: where,

      whereArgs: whereArgs,

      limit: 1,

    );

    if (result.isEmpty) {
      return null;
    }

    return result.first;

  }

  /*
  Future<void> printUsers() async {

    final users = await findAll(UserTable.table);

    print(users);

  }

   */

}