import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/task.dart';
import '../../models/task_manager.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    // Get access to TaskManager without watching for changes
    final taskManager = context.read<TaskManager>();

    return Card(
      child: ListTile(
        title: Text(task.title),
        subtitle: Text(task.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: task.isCompleted,
              onChanged: (value) {
                taskManager.updateTask(
                  Task(
                    id: task.id,
                    title: task.title,
                    description: task.description,
                    isCompleted: value ?? false,
                  ),
                );
              },
            ),
            IconButton(onPressed: () => taskManager.deleteTask(task), icon: Icon(Icons.delete)),
          ],
        )
      ),
    );
  }
}
