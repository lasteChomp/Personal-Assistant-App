// Hava durumu ekranı. Şehir adı alınıp hava durumu bilgisi gösterilir.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../providers/weather_provider.dart';
import 'weather_webview_screen.dart';

class WeatherScreen extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                weatherProvider.fetchWeather(value); // Hava durumu bilgisi çekilir
              },
            ),
          ),
          if (weatherProvider.weatherInfo != null)
            Column(
              children: [
                Text(
                  weatherProvider.weatherInfo!.description,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Image.network(weatherProvider.weatherInfo!.iconUrl), // Hava durumu simgesi
                Text(
                  '${weatherProvider.weatherInfo!.temperature}°C',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WeatherWebViewScreen(city: _cityController.text),
                ),
              );
            },
            child: Text('View More Details in Web'),
          ),
        ],
      ),
    );
  }
}