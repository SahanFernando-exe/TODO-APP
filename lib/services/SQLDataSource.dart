import 'package:flutter/widgets.dart';
import 'package:todo_app/models/Task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import './datasource_interface.dart';

class SQLDataSource implements DataSourceInterface {
  late Database _database;

  Future initialise() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'todo_data.db'),
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE IF NOT EXIST TASKS (id INTEGER PRIMARY KEY, title TEXT, description TEXT, complete INTEGER)',
        );
      },
    );
  }

  static Future<DataSourceInterface> createAsync() async {
    SQLDataSource dataSource = SQLDataSource();
    await dataSource.initialise();
    return dataSource;
  }

  @override
  Future<bool> add(Task model) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> browse() {
    // TODO: implement browse
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(Task model) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<bool> edit(Task model) {
    // TODO: implement edit
    throw UnimplementedError();
  }
}
