import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screens/weather_screen.dart';
import 'package:weather_app/services/weather_service.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => WeatherService(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WeatherScreen(),
    );
  }
}