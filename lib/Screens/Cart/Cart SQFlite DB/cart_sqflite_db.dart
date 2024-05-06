import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:vaama_dairy_mobile/Screens/Cart/Cart%20Model/item_model.dart';

class DatabaseHelper {
  late Future<Database> database;

  DatabaseHelper() {
    database = _initDatabase();
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'shopping_cart.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int newVersion) async {
    await db.execute('''
    CREATE TABLE cart_items(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      productId TEXT,
      name TEXT,
      image TEXT,
      price REAL,
      quantity INTEGER,
      units REAL,
      unitsId TEXT,
      unitsName TEXT
    )
  ''');
  }

  Future<int> insertCartItem(Map<String, dynamic> cartItem) async {
    Database db = await database;
    return await db.insert('cart_items', cartItem);
  }

  // Future<void> updateCartItem(Map<String, dynamic> cartItem) async {
  //   final db = await database;
  //   await db.update(
  //     'cart_items',
  //     cartItem,
  //     where: 'id = ?',
  //     whereArgs: [cartItem['id']],
  //   );
  // }

  Future<int> updateCartItem(CartItem cartItem) async {
    print('updated item is ${cartItem.toMap()}');
    var dbClient = await database;
    return await dbClient.update('cart_items', cartItem.toMap(), where: 'id = ?', whereArgs: [cartItem.id]);
  }

  Future<List<Map<String, dynamic>>> getCartItems() async {
    Database db = await database;
    return await db.query('cart_items');
  }

  Future<int> deleteCartItem(int id) async {
    Database db = await database;
    return await db.delete('cart_items', where: 'id =?', whereArgs: [id]);
  }

  Future<void> clearCart() async {
    Database db = await database;
    await db.delete('cart_items');
  }
}
