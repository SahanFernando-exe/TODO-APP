import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/TaskManager.dart';
import 'pages/create_task.dart';
import 'pages/home_page.dart';


void main() {
  runApp(
    // Setup Provider once at the root
    ChangeNotifierProvider(
      create: (context) => TaskManager(),
      child: MyApp(),
    ),
  );
}

// App doesn't need to manage state anymore
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      routes: {
        '/create': (context) => CreateTaskPage(),
      },
    );
  }
}