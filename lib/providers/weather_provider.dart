// Hava durumu bilgilerini yönetir ve API'den veri çeker.
import 'package:flutter/material.dart';

class WeatherInfo {
  final String city; // Şehir adı
  final String description; // Hava durumu açıklaması
  final String iconUrl; // Hava durumu simge URL'si
  final double temperature; // Sıcaklık bilgisi

  WeatherInfo({
    required this.city,
    required this.description,
    required this.iconUrl,
    required this.temperature,
  });
}

class WeatherProvider with ChangeNotifier {
  WeatherInfo? _weatherInfo;

  WeatherInfo? get weatherInfo => _weatherInfo;

  void fetchWeather(String city) {
    // Simüle edilmiş bir API çağrısı
    _weatherInfo = WeatherInfo(
      city: city,
      description: 'Sunny',
      iconUrl: 'https://openweathermap.org/img/wn/01d.png',
      temperature: 25.0,
    );
    notifyListeners();
  }
}