import 'package:flutter/material.dart';
import 'task.dart';
import '../services/datasource_interface.dart';
import '../services/hive_datasource.dart';

class TaskManager with ChangeNotifier {
  static List<Task> _tasks = <Task>[];
  final DataSourceInterface _hive_db = HiveDatasource();

  List<Task> get tasks => _tasks;

  void refreshTasks() async {
    _tasks = await _hive_db.browse();
    notifyListeners();
  }

  void addTask(Task task) async {
    await _hive_db.add(task);
    refreshTasks();
  }

  void updateTask(Task updatedTask) {
    // TODO: call db.edit() and refresh()
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners(); // Tell widgets to update
    }
  }
}
