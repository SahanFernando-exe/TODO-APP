import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'logic/TaskManager.dart';
import 'widgets/macro/task_card.dart';
import 'pages/create_task.dart';


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

// HomePage can access tasks directly without callbacks
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Watch for changes in TaskManager
    final taskManager = context.watch<TaskManager>();
    
    return Scaffold(
      appBar: AppBar(title: Text('Todo App')),
      body: ListView.builder(
        itemCount: taskManager.tasks.length,
        itemBuilder: (context, index) => TaskCard(task: taskManager.tasks[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/create'),
        child: Icon(Icons.add),
      ),
    );
  }
}