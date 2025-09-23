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
    DataSourceInterface db = Get.find();
    _tasks = await db.browse();
    notifyListeners();
  }

  void addTask(Task task) async {
    DataSourceInterface db = Get.find();
    await db.add(task);
    refreshTasks();
  }

  void updateTask(Task updatedTask) async {
    DataSourceInterface db = Get.find();
    await db.edit(updatedTask);
    refreshTasks();
  }

  void deleteTask(Task task) async {
    DataSourceInterface db = Get.find();
    await db.delete(task);
    refreshTasks();
  }
}
