import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'task.dart';
import '../services/datasource_interface.dart';

//state model
class TaskManager with ChangeNotifier {
  static List<Task> _tasks = <Task>[];

  List<Task> get tasks => _tasks;

  TaskManager() {
    refreshTasks();
  }

  void refreshTasks() async {
    debugPrint('refreshing....');
    DataSourceInterface _db = Get.find();
    _tasks = await _db.browse();
    notifyListeners();
  }

  void addTask(Task task) async {
    DataSourceInterface _db = Get.find();
    await _db.add(task);
    refreshTasks();
  }

  void updateTask(Task updatedTask) async {
    DataSourceInterface _db = Get.find();
    await _db.edit(updatedTask);
    refreshTasks();
  }

  void deleteTask(Task task) async {
    DataSourceInterface _db = Get.find();
    await _db.delete(task);
    refreshTasks();
  }
}
