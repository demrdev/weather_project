import 'package:dio/dio.dart';

import '../models/weather.dart';
import 'network_service.dart';

class WeatherService {
  final String _apiKey = 'YOUR_API_KEY';
  final NetworkService _networkService;

  WeatherService()
      : _networkService = NetworkService.getInstance(
          baseOptions: BaseOptions(
            baseUrl: 'https://api.openweathermap.org/data/2.5',
            queryParameters: {'appid': 'YOUR_API_KEY', 'units': 'metric'},
          ),
        );

  Future<Weather> fetchWeatherByCityName(String cityName) async {
    try {
      final response = await _networkService.dio.get('/weather', queryParameters: {'q': cityName});
      if (response.statusCode == 200) {
        return Weather.fromJson(response.data);
      } else {
        throw Exception('Error fetching weather: ${response.statusMessage}');
      }
    } on DioError catch (e) {
      throw Exception('Error: ${e.response?.statusMessage ?? e.message}');
    }
  }
}
