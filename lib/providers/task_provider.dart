// Görev yönetimi için TaskProvider.
import 'package:flutter/foundation.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = []; // Görev listesi

  List<Task> get tasks => _tasks; // Görevleri döndür

  void addTask(String title, String description, DateTime? dateTime) {
    _tasks.add(Task(title: title, description: description, dateTime: dateTime)); // Yeni görev ekle
    notifyListeners(); // Değişiklik bildir
  }

  void updateTask(int index, String title, String description, DateTime? dateTime) {
    _tasks[index].title = title; // Görev başlığını güncelle
    _tasks[index].description = description; // Görev içeriğini güncelle
    _tasks[index].dateTime = dateTime;
    notifyListeners();
  }

  void toggleTask(int index) {
    _tasks[index].completed = !_tasks[index].completed; // Görev tamamlandı durumunu değiştir
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index); // Görevi sil
    notifyListeners();
  }
}