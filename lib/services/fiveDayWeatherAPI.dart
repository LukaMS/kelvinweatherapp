import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ForecastAPI {
  final String apiKey;
  final String baseUrl;

  ForecastAPI({required this.apiKey, required this.baseUrl});

  Future<List<Map<String, dynamic>>> getForecastByCity(String cityName, String unit) async {
    final response = await http.get(Uri.parse(
        '$baseUrl?q=$cityName&appid=$apiKey&units=${_getApiUnit(unit)}'));
    print('$baseUrl?q=$cityName&appid=$apiKey&units=${_getApiUnit(unit)}');
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print("test");
      return _extractTemperatureData(jsonData);
    } else {
      throw Exception('Failed to load forecast');
    }
  }

  Future<List<Map<String, dynamic>>> getForecastByLocation(
      double lat, double lon, String unit) async {
    final response = await http.get(Uri.parse(
        '$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=${_getApiUnit(unit)}'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return _extractTemperatureData(jsonData);
    } else {
      throw Exception('Failed to load forecast');
    }
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

  List<Map<String, dynamic>> _extractTemperatureData(dynamic jsonData) {
    List<dynamic> forecasts = jsonData['list'];
    Map<String, Map<String, dynamic>> forecastData = {};

    for (var forecast in forecasts) {
      DateTime dateTime = DateTime.parse(forecast['dt_txt']);
      String date = DateFormat('yyyy-MM-dd').format(dateTime).toString();
      int hour = dateTime.hour;

      if (hour == 9) {
        // Morning temperature
        if (!forecastData.containsKey(date)) {
          forecastData[date] = {
            'date': DateFormat('yyyy-MM-dd').parse(date).toString(),
            'morningTemperature': forecast['main']['temp'].toDouble()
          };
        }
      } else if (hour == 21) {
        // Evening temperature
        if (forecastData.containsKey(date)) {
          forecastData[date]?['eveningTemperature'] = forecast['main']['temp'].toDouble();
        }
      }
    }
    print(forecastData.values.toList());
    return forecastData.values.toList();
  }
}
