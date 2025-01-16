// Görev modeli. Görev bilgilerini saklar.
class Task {
  String title; // Görev başlığı
  String description; // Görev içeriği
  bool completed; // Görev tamamlandı mı?
  DateTime? dateTime; // Görevin tarihi ve saati

  Task({
    required this.title,
    required this.description,
    this.completed = false,
    this.dateTime,
  });
}