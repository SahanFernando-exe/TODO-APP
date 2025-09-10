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
    debugPrint("hive add called");
    Box<Task> box = await Hive.openBox('tasks');
    debugPrint("box made");
    String key = model.id;
    debugPrint("got key");
    box.put(key, model);
    debugPrint("box put");
    return true;
  }

  @override
  Future<List<Task>> browse() async {
    debugPrint("browse called");
    Box<Task> box = Hive.box('tasks');
    debugPrint("got box");
    return box.values.toList();
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
