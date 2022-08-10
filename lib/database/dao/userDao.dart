import 'package:sqflite/sqflite.dart'; //sqflite package
import 'dart:async';
import 'package:login/database/UserDbProvider.dart';
import '../../models/user.dart';

class UserDao{

  Future<List<User>> GetUsers() async{

    final db = await UserDbProvider().init();
    final List<Map<String, dynamic>> maps = await db.query('Users');

    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        name: maps[i]['name'],
        phone: maps[i]['phone'],
        password: maps[i]['password'],
      );
    });
  }

  Future<int> CreateUser(User item) async{ //returns number of items inserted as an integer

    final db = await UserDbProvider().init(); //open database

    return db.insert("Users", item.toMap(), //toMap() function from MemoModel
      conflictAlgorithm: ConflictAlgorithm.ignore, //ignores conflicts due to duplicate entries
    );
  }

  Future<int> DeleteUser(int id) async{ //returns number of items deleted
    final db = await UserDbProvider().init();

    int result = await db.delete(
        "Users", //table name
        where: "id = ?",
        whereArgs: [id] // use whereArgs to avoid SQL injection
    );

    return result;
  }

  Future<int> UpdateUser(int id, User item) async{ // returns the number of rows updated

    final db = await UserDbProvider().init();

    int result = await db.update(
        "Users",
        item.toMap(),
        where: "id = ?",
        whereArgs: [id]
    );
    return result;
  }
}
