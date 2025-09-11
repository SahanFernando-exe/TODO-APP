import 'package:flutter/material.dart';
import 'task.dart';
import '../services/datasource_interface.dart';
import '../services/hive_datasource.dart';

class TaskManager with ChangeNotifier {
  static List<Task> _tasks = <Task>[];
  final DataSourceInterface _hive_db = HiveDatasource();

  List<Task> get tasks => _tasks;

  TaskManager() {
    refreshTasks();
  }

  void refreshTasks() async {
    _tasks = await _hive_db.browse();
    notifyListeners();
  }

  void addTask(Task task) async {
    await _hive_db.add(task);
    refreshTasks();
  }

  void updateTask(Task updatedTask) async {
    await _hive_db.edit(updatedTask);
    refreshTasks();
  }

  void deleteTask(Task task) async {
    await _hive_db.delete(task);
    refreshTasks();
  }
}
