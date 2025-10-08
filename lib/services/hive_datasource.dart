import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/task.dart';
import 'datasource_interface.dart';

class HiveDatasource implements DataSourceInterface {
  static Future<DataSourceInterface> createAsync() async {
    HiveDatasource datasource = HiveDatasource();
    await datasource.Initialise();
    return datasource;
  }

  Future Initialise() async {
    debugPrint('box creation');
    await Hive.initFlutter();
    Hive.registerAdapter(TaskAdapter());
    await Hive.openBox<Task>('tasks');
  }

  @override
  Future<bool> add(Task model) async {
    try {
      debugPrint("hive add called");
      Box<Task> box = await Hive.openBox('tasks');
      String key = model.id;
      box.put(key, model);
      return true;
    } catch (e) {
      debugPrint('Hive - Error adding task: $e');
      return false;
    }
  }

  @override
  Future<List<Task>> browse() async {
    debugPrint("Hive Browse called");
    Box<Task> box = Hive.box('tasks');
    return box.values.toList();
  }

  @override
  Future<bool> delete(Task model) async {
    try {
      Box<Task> box = await Hive.openBox('tasks');
      box.delete(model.id);
      return true;
    } catch (e) {
      debugPrint('Hive - Error deleting task: $e');
      return false;
    }
  }

  @override
  Future<bool> edit(Task model) async {
    debugPrint("hive edit");
    List list = await browse();
    for (var object in list) {
      if (object.id == model.id) {
        add(model);
      }
    }
    return true;
  }
}
