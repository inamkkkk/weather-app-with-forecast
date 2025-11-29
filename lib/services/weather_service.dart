import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherService extends ChangeNotifier {
  WeatherModel? _weatherData;
  ForecastModel? _forecastData;
  final String apiKey = 'YOUR_API_KEY';

  WeatherModel? get weatherData => _weatherData;
  ForecastModel? get forecastData => _forecastData;

  Future<void> fetchWeatherAndForecast(String city) async {
    await fetchWeatherData(city);
    await fetchForecastData(city);
    notifyListeners();
  }

  Future<void> fetchWeatherData(String city) async {
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      _weatherData = WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<void> fetchForecastData(String city) async {
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      _forecastData = ForecastModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load forecast data');
    }
  }
}