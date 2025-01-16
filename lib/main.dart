// Ana uygulama dosyası. Uygulama başlatılır ve Provider'lar tanımlanır.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/reminders_screen.dart';
import 'screens/weather_screen.dart';
import 'screens/weather_webview_screen.dart';
import 'providers/task_provider.dart';
import 'providers/weather_provider.dart';

void main() {
  runApp(
    // MultiProvider ile birden fazla Provider tanımlanır.
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: PersonalAssistantApp(), // Ana uygulama widget'ı
    ),
  );
}

class PersonalAssistantApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Assistant', // Uygulama başlığı
      theme: ThemeData(
        primarySwatch: Colors.blue, // Ana tema rengi
        fontFamily: 'Roboto', // Varsayılan yazı tipi
      ),
      home: HomeScreen(), // İlk açılacak ekran
    );
  }
}