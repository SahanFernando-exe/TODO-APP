import 'package:flutter/material.dart';
import '/models/Task.dart';

class TaskManager with ChangeNotifier {
  List<Task> _tasks = [];
  
  List<Task> get tasks => _tasks;
  
  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners(); // Tell widgets to update
  }
  
  void updateTask(Task updatedTask) {
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners(); // Tell widgets to update
    }
  }
}