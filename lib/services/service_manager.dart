import 'package:flutter/foundation.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/services/datasource_interface.dart';
import 'package:todo_app/services/sql_datasource.dart';
import 'package:todo_app/services/hive_datasource.dart';
import 'package:todo_app/services/firebase_datasource.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
//import 'dart:html' as html;

class DataServiceManager implements DataSourceInterface {
  late final tododatasource_local;
  late final tododatasource_remote;

  // DataServiceManager() {
  //   if (kIsWeb) {
  //     tododatasource_local = HiveDatasource();
  //   } else {
  //     tododatasource_local = SQLDatasource();
  //   }
  // }

  static Future<DataServiceManager> createAsync() async {
    DataServiceManager manager = DataServiceManager();
    manager.tododatasource_remote = await FirebaseDatasource.createAsync();
    if (kIsWeb) {
      manager.tododatasource_local = await HiveDatasource.createAsync();
    } else {
      manager.tododatasource_local = await SQLDatasource.createAsync();
    }
    return manager;
  }

  Future<bool> _isConnected() async {
    // if ((kIsWeb && html.window.navigator.onLine == false) ||
    List list = await Connectivity().checkConnectivity();
    if ((kIsWeb) || (list.contains(ConnectivityResult.none))) {
      return false;
    }
    return true;
  }

  @override
  Future<bool> add(Task model) async {
    return await _isConnected()
        ? await tododatasource_remote.add(model)
        : await tododatasource_local.add(model);
  }

  @override
  Future<List<Task>> browse() async {
    if (await _isConnected()) {
      return await tododatasource_remote.browse();
    }
    return await tododatasource_local.browse();
  }

  @override
  Future<bool> delete(Task model) async {
    return await _isConnected()
        ? await tododatasource_remote.delete(model)
        : await tododatasource_local.delete(model);
  }

  @override
  Future<bool> edit(Task model) async {
    return await _isConnected()
        ? await tododatasource_remote.edit(model)
        : await tododatasource_local.edit(model);
  }
}
