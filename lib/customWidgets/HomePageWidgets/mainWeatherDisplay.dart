import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/services/settingsProvider.dart';
import 'package:weatherapp/services/weatherProvider.dart';
import 'package:weatherapp/services/weatherModel.dart';

class MainWeatherDisplay extends StatefulWidget {
  final WeatherModel? weatherData;

  const MainWeatherDisplay({super.key, this.weatherData});

  @override
  _MainWeatherDisplayState createState() => _MainWeatherDisplayState();
}

class _MainWeatherDisplayState extends State<MainWeatherDisplay> {

  @override
  Widget build(BuildContext context) {
    return Consumer2<SettingsProvider, WeatherProvider>(
      builder: (context, settingsProvider, weatherProvider, child) {
        final unit = settingsProvider.unit; // Get the current unit (Kelvin or Celsius)
        final weatherData = weatherProvider.weatherData;
        if (weatherProvider.errorMessage != null) {
          return Center(
            child: Text(
              weatherProvider.errorMessage!,
              style: const TextStyle(color: Colors.red, fontSize: 18),
            ),
          );
        }

        if (weatherData == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Temperature Display
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Current Temperature
                      Text(
                        unit == 'Kelvin'
                            ? '${weatherData.temperature.toStringAsFixed(1)} K'
                            : '${(weatherData.temperature).toStringAsFixed(1)} °C',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10), // Spacer
                      // Feels Like Temperature
                      Text(
                        unit == 'Kelvin'
                            ? 'Feels ${weatherData.feelsLike.toStringAsFixed(1)} K'
                            : 'Feels ${(weatherData.feelsLike).toStringAsFixed(1)} °C',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Icon and Description Display
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Weather Icon
                      Image.asset(
                        'assets/weatherIcons/${weatherData.image}.png',
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 10), // Spacer
                      // Weather Description
                      Text(
                        weatherData.description, // Display the description
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
