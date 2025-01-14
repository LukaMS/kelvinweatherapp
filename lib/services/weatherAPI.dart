import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:weatherapp/services/settingsProvider.dart';
import 'package:weatherapp/services/weatherModel.dart';

class WeatherAPI {
  final String apiKey;
  final String baseUrl;

  WeatherAPI({required this.apiKey, required this.baseUrl});

  Future<WeatherModel> getWeatherByCity(String city, String unit) async {
    final apiUrl = '$baseUrl?q=$city&appid=$apiKey&units=${_getApiUnit(unit)}';
    print(apiUrl);
    return _fetchWeather(apiUrl);
  }

  Future<WeatherModel> getWeatherByLocation(
      double latitude, double longitude, String unit) async {
    final apiUrl =
        '$baseUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=${_getApiUnit(unit)}';
    print(apiUrl);
    return _fetchWeather(apiUrl);
  }

  String _getApiUnit(String unit) {
    switch (unit) {
      case 'Celsius':
        return 'metric'; // OpenWeatherMap API uses 'metric' for Celsius
      case 'Kelvin':
        return ''; // Default for Kelvin (no units parameter needed)
      default:
        return 'metric'; // Default to Celsius
    }
  }

  Future<WeatherModel> _fetchWeather(String apiUrl) async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return WeatherModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
