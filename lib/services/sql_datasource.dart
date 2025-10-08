import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import './datasource_interface.dart';

class SQLDatasource implements DataSourceInterface {
  late Database _database;

  Future initialise() async {
    // await deleteDatabase(join(await getDatabasesPath(), 'todo_data.db'));
    _database = await openDatabase(
      join(await getDatabasesPath(), 'todo_data.db'),
      version: 1,
      onCreate: (db, version) {
        debugPrint("create table..");
        return db.execute(
          'CREATE TABLE IF NOT EXISTS tasks (id INTEGER PRIMARY KEY, name TEXT, description TEXT, complete INTEGER)',
        );
      },
    );
  }

  static Future<DataSourceInterface> createAsync() async {
    SQLDatasource dataSource = SQLDatasource();
    await dataSource.initialise();
    return dataSource;
  }

  @override
  Future<bool> add(Task model) async {
    int complete = model.isCompleted ? 1 : 0;
    _database.execute(
      "INSERT INTO tasks (name, description, complete) VALUES ('${model.title}', '${model.description}', $complete);",
    );
    return true;
  }

  @override
  Future<List<Task>> browse() async {
    List<Task> results = [];
    List<dynamic> query = await _database.query('tasks');
    query.map((e) => (Map<String, dynamic>.from(e))).forEach((item) {
      debugPrint(item.toString());
      Task task = Task.fromMap(item);
      results.add(task);
    });
    return results;
  }

  @override
  Future<bool> delete(Task model) async {
    _database.execute("DELETE FROM tasks WHERE id = ${model.id};");
    return true;
  }

  @override
  Future<bool> edit(Task model) async {
    int complete = model.isCompleted ? 1 : 0;
    _database.execute(
      "UPDATE tasks SET name = '${model.title}', description = '${model.description}', complete = $complete WHERE id = ${model.id};",
    );
    return true;
  }
}
