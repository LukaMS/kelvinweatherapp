import 'package:flutter/material.dart';
import 'package:weatherapp/services/weatherModel.dart';
import 'package:weatherapp/services/weatherProvider.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/pages/settings.dart';

class settingsButton extends StatelessWidget {

  final WeatherModel? weatherData;

  const settingsButton({Key? key, this.weatherData}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings, color: Colors.white),
      onPressed: () async {
        // Navigate to the Settings page and wait for the result
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Settings()),
        );

        // If settings were updated, reload the weather data
        if (result == true) {
          await Provider.of<WeatherProvider>(context, listen: false)
              .fetchWeatherByCity(context, weatherData!.cityName);
          await Provider.of<WeatherProvider>(context, listen: false)
              .fetchForecastByCity(context, weatherData!.cityName);
        }
      },
    );
  }
}
