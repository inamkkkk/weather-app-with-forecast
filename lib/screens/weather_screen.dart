import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<WeatherService>(context, listen: false).fetchWeatherAndForecast('London');
  }

  @override
  Widget build(BuildContext context) {
    final weatherService = Provider.of<WeatherService>(context);
    final weatherData = weatherService.weatherData;
    final forecastData = weatherService.forecastData;

    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')), body: weatherData == null ? const Center(child: CircularProgressIndicator()) : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Weather', style: Theme.of(context).textTheme.headline5),
            Text('City: ${weatherData.name}'),
            Text('Temperature: ${weatherData.main.temp}°C'),
            Text('Description: ${weatherData.weather[0].description}'),
            Text('Humidity: ${weatherData.main.humidity}%'),
            Text('Wind Speed: ${weatherData.wind.speed} m/s'),
            const SizedBox(height: 20),
            Text('5-Day Forecast', style: Theme.of(context).textTheme.headline5),
            SizedBox(
              height: 200,
              child: forecastData == null ? const Center(child: Text('No forecast available')) : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: forecastData.list.length,
                itemBuilder: (context, index) {
                  final forecast = forecastData.list[index];
                  final dateTime = DateTime.fromMillisecondsSinceEpoch(forecast.dt * 1000);
                  final formattedDate = DateFormat('EEE, h:mm a').format(dateTime);
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(formattedDate),
                          Text('Temperature: ${forecast.main.temp}°C'),
                          Text('Description: ${forecast.weather[0].description}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}