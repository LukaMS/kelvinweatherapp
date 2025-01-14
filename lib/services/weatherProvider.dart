import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/services/fiveDayWeatherAPI.dart';
import 'package:weatherapp/services/fiveDayWeatherModel.dart';
import 'package:weatherapp/services/weatherModel.dart';
import 'package:weatherapp/services/weatherAPI.dart';
import 'package:weatherapp/services/settingsProvider.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherAPI weatherService;
  final ForecastAPI forecastService;

  WeatherModel? _weatherData;
  String? _errorMessage;
  List<ForecastModel>? _forecastDataList;

  WeatherProvider({required this.weatherService, required this.forecastService});

  WeatherModel? get weatherData => _weatherData; // Getter for weather data
  List<ForecastModel>? get forecastDataList => _forecastDataList; // Getter for forecast data list
  String? get errorMessage => _errorMessage; // Getter for error message

  // Method to fetch weather data by city name with units from SettingsProvider
  Future<void> fetchWeatherByCity(BuildContext context, String city) async {
    try {
      final unit = Provider.of<SettingsProvider>(context, listen: false).unit;
      final weather = await weatherService.getWeatherByCity(city, unit);
      _weatherData = weather;
      _errorMessage = null;
    } catch (e) {
      _weatherData = null;
      _errorMessage = 'Failed to fetch weather data';
      print(e);
    }
    notifyListeners();
  }

  // Method to fetch weather data by latitude and longitude with units from SettingsProvider
  Future<void> fetchWeatherByLocation(BuildContext context, double latitude, double longitude) async {
    try {
      final unit = Provider.of<SettingsProvider>(context, listen: false).unit;
      final weather = await weatherService.getWeatherByLocation(latitude, longitude, unit);
      _weatherData = weather;
      _errorMessage = null;
    } catch (e) {
      _weatherData = null;
      _errorMessage = 'Failed to fetch weather data';
    }
    notifyListeners();
  }

  // Method to fetch forecast data by city with units from SettingsProvider
  Future<void> fetchForecastByCity(BuildContext context, String city) async {
    try {
      final unit = Provider.of<SettingsProvider>(context, listen: false).unit;
      final forecast = await forecastService.getForecastByCity(city, unit);
      _forecastDataList = forecast.map((data) => ForecastModel.fromJson(data)).toList();
      _errorMessage = null;
    } catch (e) {
      _forecastDataList = null;
      _errorMessage = 'Failed to fetch forecast data';
      print(e);
    }
    notifyListeners();
  }

  // Method to fetch forecast data by latitude and longitude with units from SettingsProvider
  Future<void> fetchForecastByLocation(BuildContext context, double latitude, double longitude) async {
    try {
      final unit = Provider.of<SettingsProvider>(context, listen: false).unit;
      final forecast = await forecastService.getForecastByLocation(latitude, longitude, unit);
      _forecastDataList = forecast.map((data) => ForecastModel.fromJson(data)).toList();
      _errorMessage = null;
    } catch (e) {
      _forecastDataList = null;
      _errorMessage = 'Failed to fetch forecast data';
    }
    notifyListeners();
  }
}
