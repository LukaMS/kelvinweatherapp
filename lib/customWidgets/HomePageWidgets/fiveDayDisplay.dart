import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/services/fiveDayWeatherModel.dart';
import 'package:weatherapp/services/settingsProvider.dart';
import 'package:weatherapp/services/weatherProvider.dart';

class FiveDayDisplay extends StatelessWidget {
  final List<ForecastModel>? fiveDayWeatherData;

  const FiveDayDisplay({super.key, this.fiveDayWeatherData});

  @override
  Widget build(BuildContext context) {
    return Consumer2<SettingsProvider, WeatherProvider>(
      builder: (context, settingsProvider, weatherProvider, child) {
        final unit = settingsProvider.unit; // Get the current unit
        final forecastData = weatherProvider.forecastDataList;

        return Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 96, 33, 243).withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '5 Day Forecast',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'AM/PM',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15), // Spacing between title and content
              if (forecastData != null)
                ...forecastData.map((dayWeather) => weatherRow(dayWeather, unit)).toList()
              else
                const Text(
                  'Loading...',
                  style: TextStyle(color: Colors.white),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget weatherRow(ForecastModel dayWeather, String unit) {
    final dayOfWeek = DateFormat('EEE').format(dayWeather.date); // Format date to day of the week
    final weatherIcon = Icon(Icons.wb_sunny, color: Colors.yellow); // Placeholder for weather icon

    // Convert temperatures based on unit
    final morningTemp = unit == 'Kelvin'
        ? dayWeather.morningTemperature.round()
        : (dayWeather.morningTemperature).round();
    final eveningTemp = unit == 'Kelvin'
        ? dayWeather.eveningTemperature.round()
        : (dayWeather.eveningTemperature).round();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dayOfWeek, // Day of the week
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(child: weatherIcon),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "$morningTemp / $eveningTemp", // Max and Min temperature with AM/PM
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
