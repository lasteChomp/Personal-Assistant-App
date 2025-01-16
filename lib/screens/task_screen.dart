// Görev ekranı. Tüm görevlerin eklenip düzenlendiği yer.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

Future<DateTime?> selectDateTime(BuildContext context) async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (selectedDate == null) return null;

  TimeOfDay? selectedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (selectedTime == null) return selectedDate;

  return DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
    selectedTime.hour,
    selectedTime.minute,
  );
}

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                final task = taskProvider.tasks[index];
                return Card(
                  child: ListTile(
                    title: Text(task.title), // Görev başlığı
                    subtitle: Text(task.description), // Görev içeriği
                    trailing: Checkbox(
                      value: task.completed,
                      onChanged: (value) {
                        taskProvider.toggleTask(index);
                      },
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          TextEditingController titleController =
                          TextEditingController(text: task.title);
                          TextEditingController descriptionController =
                          TextEditingController(text: task.description);
                          DateTime? selectedDateTime = task.dateTime;

                          return AlertDialog(
                            title: Text('Edit Task'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: titleController,
                                  decoration: InputDecoration(hintText: 'Task Title'),
                                ),
                                TextField(
                                  controller: descriptionController,
                                  decoration: InputDecoration(hintText: 'Task Description'),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    selectedDateTime = await selectDateTime(context); // Tarih ve saat seçimi
                                  },
                                  child: Text('Set Date & Time'),
                                ),
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  taskProvider.deleteTask(index);
                                  Navigator.pop(context);
                                },
                                child: Text('Delete Task'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  taskProvider.updateTask(
                                    index,
                                    titleController.text,
                                    descriptionController.text,
                                    selectedDateTime,
                                  );
                                  Navigator.pop(context);
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  TextEditingController titleController = TextEditingController();
                  TextEditingController descriptionController = TextEditingController();
                  DateTime? selectedDateTime;
                  return AlertDialog(
                    title: Text('Add Task'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: InputDecoration(hintText: 'Task Title'),
                        ),
                        TextField(
                          controller: descriptionController,
                          decoration: InputDecoration(hintText: 'Task Description'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            selectedDateTime = await selectDateTime(context); // Tarih ve saat seçimi
                          },
                          child: Text('Set Date & Time'),
                        ),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
                            taskProvider.addTask(
                              titleController.text,
                              descriptionController.text,
                              selectedDateTime,
                            );
                          }
                          Navigator.pop(context);
                        },
                        child: Text('Add Task'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}