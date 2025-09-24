import 'package:flutter/foundation.dart';
import 'package:todo_app/services/sql_datasource.dart';
import 'package:todo_app/services/hive_datasource.dart';
import 'package:todo_app/services/firebase_datasource.dart';

class DataServiceManager {
  late final tododatasource_local;
  final tododatasource_remote = FirebaseDatasource();

  DataServiceManager() {
    if (kIsWeb) {
      tododatasource_local = HiveDatasource();
    } else {
      tododatasource_local = SQLDatasource();
    }
  }
}
