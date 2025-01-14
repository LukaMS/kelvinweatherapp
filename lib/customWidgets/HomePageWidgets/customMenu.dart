import 'package:flutter/material.dart';
import 'package:weatherapp/services/weatherModel.dart';

class CustomMenu extends StatelessWidget {

  WeatherModel? weatherData;

  CustomMenu({super.key, this.weatherData});

  @override
  Widget build(BuildContext context) {

    String displayText;

    if (weatherData != null) {
      displayText = "${weatherData!.flagEmoji} ${weatherData!.cityName}";
    } else {
      displayText = 'Loading...';
    }

    return Text(
      displayText,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}