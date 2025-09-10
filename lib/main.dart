import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/services/hive_datasource.dart';
import './services/datasource_interface.dart';
import 'models/task_manager.dart';
import 'pages/create_task.dart';
import 'pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.putAsync<DataSourceInterface>(
    () => HiveDatasource.createAsync(),
  ).whenComplete(
    () => runApp(
      // Setup Provider once at the root
      ChangeNotifierProvider(
        create: (context) => TaskManager(),
        child: TodoApp(),
      ),
    ),
  );
}

// App doesn't need to manage state anymore
class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      routes: {'/create': (context) => CreateTaskPage()},
      debugShowCheckedModeBanner: false,
    );
  }
}
