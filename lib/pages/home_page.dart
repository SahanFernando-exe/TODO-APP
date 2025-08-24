import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/TaskManager.dart';
import '/widgets/macro/task_card.dart';

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