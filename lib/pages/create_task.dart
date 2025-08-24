import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/Task.dart';
import '/logic/TaskManager.dart';

class CreateTaskPage extends StatefulWidget {
  @override
  _CreateTaskPageState createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    // Get access to TaskManager without watching for changes
    final taskManager = context.read<TaskManager>();
    
    return Scaffold(
      appBar: AppBar(title: Text('Create Task')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title', errorText: Task.validateTitle(_titleController.text)),
              onChanged: (value) {setState(() {});}, // Rebuild to show validation errors
            ),

            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description', errorText: Task.validateDescription(_descriptionController.text)),
              onChanged: (value) {setState(() {});}, // Rebuild to show validation errors
            ),

            ElevatedButton(
              onPressed: () {
                // Add directly through TaskManager
                taskManager.addTask(Task(
                  id: DateTime.now().toString(),
                  title: _titleController.text,
                  description: _descriptionController.text,
                ));
                Navigator.pop(context);
              },
              child: Text('Create Task'),
            ),
          ],
        ),
      ),
    );
  }
}