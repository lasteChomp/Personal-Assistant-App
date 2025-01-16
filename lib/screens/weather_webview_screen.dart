import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WeatherWebViewScreen extends StatelessWidget {
  final String city;

  WeatherWebViewScreen({required this.city});

  @override
  Widget build(BuildContext context) {
    final weatherUrl = 'https://www.google.com/search?q=weather+in+$city';

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Details'),
      ),
      body: WebView(
        initialUrl: weatherUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
