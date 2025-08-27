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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'complete': isCompleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    bool? complete = map['complete'] is bool ? map['complete'] : null;
    complete ??= map['complete'] == 1 ? true : false;

    return Task(
      id: map['id'].toString(),
      title: map['title'],
      description: map['description'],
      isCompleted: complete,
    );
  }
}
