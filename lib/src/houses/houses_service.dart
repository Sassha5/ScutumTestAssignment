import 'package:flutter/material.dart';
import 'package:scutum_test_assignment/src/app.dart';
import 'package:sqflite/sqflite.dart';

import 'house.dart';

/// A service that stores and retrieves items from database.

class HousesService {
  static const String housesTableName = 'houses';

  /// Loads the User's preferred ThemeMode from local or remote storage.
  Future<ThemeMode> themeMode() async => ThemeMode.system;

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
  }

  Future<List<House>> getHouses() async {
    // Make sure that db instance is ready
    var db = await MyApp.dbFuture;
    // Query the table for all The Houses.
    final List<Map<String, dynamic>> maps = await db.query(housesTableName);

    // Convert the List<Map<String, dynamic> into a List<House>.
    return List.generate(maps.length, (i) {
      var house = House(
        maps[i]['name'] as String,
        maps[i]['floors'] as int,
      );
      house.id = maps[i]['id'] as int;

      return house;
    });
  }

  Future addHouse(House item) async {
    var db = await MyApp.dbFuture;

    await db.insert(
      housesTableName,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
