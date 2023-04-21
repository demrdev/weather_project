import 'package:flutter/material.dart';

import '../models/weather.dart';
import '../services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityNameController = TextEditingController();
  final WeatherService _weatherService = WeatherService();
  Weather? _weather;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _cityNameController,
              decoration: InputDecoration(
                labelText: 'City Name',
            hintText: 'Enter city name',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () async {
            if (_cityNameController.text.isNotEmpty) {
              try {
                final weather = await _weatherService.fetchWeatherByCityName(_cityNameController.text);
                setState(() {
                  _weather = weather;
                  _errorMessage = null;
                });
              } catch (e) {
                setState(() {
                  _weather = null;
                  _errorMessage = e.toString();
                });
              }
            }
          },
          child: Text('Get Weather'),
        ),
        SizedBox(height: 32.0),
        if (_weather != null)
          Column(
            children: [
              Text(
                '${_weather!.cityName}',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                '${_weather!.temperature.toStringAsFixed(1)}°C',
                style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
              ),
            ],
          )
        else if (_errorMessage != null)
          Text(
            'Error: $_errorMessage',
            style: TextStyle(color: Colors.red),
          ),
      ],
    ),
  ),
);
  }
}