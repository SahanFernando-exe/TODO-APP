import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/Task.dart';
import 'datasource_interface.dart';

class HiveDatasource implements DataSourceInterface {
  static Future<DataSourceInterface> createAsync() async {
    HiveDatasource datasource = HiveDatasource();
    await datasource.Initialise();
    return datasource;
  }

  Future Initialise() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskAdapter());
    await Hive.openBox<Task>('tasks');
  }

  @override
  Future<bool> add(Task model) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> browse() async {
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
