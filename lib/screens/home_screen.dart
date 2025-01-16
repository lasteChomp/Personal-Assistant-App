// Ana ekran dosyası. Görevler tamamlanmış ve tamamlanmamış olarak iki kategoriye ayrılır.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../providers/weather_provider.dart';
import 'task_screen.dart';
import 'weather_screen.dart';
import 'reminders_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final weatherProvider = Provider.of<WeatherProvider>(context);

    final upcomingTasks = taskProvider.tasks.where((task) {
      if (task.dateTime == null || task.completed) return false;
      final now = DateTime.now();
      final difference = task.dateTime!.difference(now).inDays;
      return difference <= 1 && difference >= 0;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Assistant'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menu', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              title: Text('Tasks'), // Görev ekranına gitmek için buton
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TaskScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Weather'), // Hava durumu ekranına gitmek için buton
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WeatherScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Reminders'), // Hatırlatıcılar ekranına gitmek için buton
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RemindersScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Hava durumu bilgisi gösterilir
          Container(
            padding: EdgeInsets.all(16.0),
            child: weatherProvider.weatherInfo != null
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'City: ${weatherProvider.weatherInfo!.city}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Weather: ${weatherProvider.weatherInfo!.description}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Temperature: ${weatherProvider.weatherInfo!.temperature}°C',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            )
                : Text('Weather: Loading...'),
          ),
          if (upcomingTasks.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text('Upcoming Tasks:', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            ...upcomingTasks.map((task) => ListTile(
              title: Text(task.title),
              subtitle: Text('Due: ${task.dateTime}'),
            )),
          ],
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('Incomplete Tasks', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                ...taskProvider.tasks
                    .where((task) => !task.completed)
                    .map((task) => Card(
                  child: ListTile(
                    title: Text(task.title),
                    subtitle: Text(task.description),
                    trailing: Checkbox(
                      value: task.completed,
                      onChanged: (value) {
                        taskProvider.toggleTask(taskProvider.tasks.indexOf(task));
                      },
                    ),
                  ),
                )),
                ListTile(
                  title: Text('Completed Tasks', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                ...taskProvider.tasks
                    .where((task) => task.completed)
                    .map((task) => Card(
                  child: ListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                    subtitle: Text(
                      task.description,
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                    trailing: Checkbox(
                      value: task.completed,
                      onChanged: (value) {
                        taskProvider.toggleTask(taskProvider.tasks.indexOf(task));
                      },
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}