import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_weather_app/models/weather_model.dart';
import 'package:minimal_weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('5c7a30c0e0bd1c02a992fc89fafbb5b6');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/loading.json';

    switch (mainCondition.toLowerCase()) {
      case 'thunderstorm':
        return 'assets/rain.json';
      case 'drizzle':
        return 'assets/rain.json';
      case 'rain':
        return 'assets/rain.json';
      case 'snow':
        return 'assets/rainy.json';
      case 'atmosphere':
        return 'assets/cloudy.json';
      case 'clear':
        return 'assets/sunny.json';
      case 'clouds':
        return 'assets/cloudy.json';
      default:
        return 'assets/cloudy.json';
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_weather?.cityName ?? 'Loading city..'),
          // animation
          Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
          Text('${_weather?.temperature.round()}°C'),

          Text(_weather?.mainCondition ?? ""),
        ],
      ),
    ));
  }
}
