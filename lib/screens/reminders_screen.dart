// Hatırlatıcılar ekranı. Tüm görevlerin hatırlatıcıları burada listelenir.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class RemindersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final reminderTasks = taskProvider.tasks
        .where((task) => task.dateTime != null && !task.completed)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Reminders'),
      ),
      body: ListView.builder(
        itemCount: reminderTasks.length,
        itemBuilder: (context, index) {
          final task = reminderTasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text('Due: ${task.dateTime}'),
          );
        },
      ),
    );
  }
}