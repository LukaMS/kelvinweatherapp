import 'package:flutter/material.dart';
import 'package:weatherapp/services/weatherModel.dart';

class specificWeatherInfo extends StatelessWidget {
  final WeatherModel? weatherData;

  const specificWeatherInfo({super.key, this.weatherData});

  @override
  Widget build(BuildContext context) {
    // Define a common style for the info values
    final infoValueStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);

    // Modified helper method to support both text and image labels
    Widget infoSquare({String? label, required String value, String? imagePath}) {
      return Expanded(
        child: Container(
          height: 100, // Set a fixed height for the square
          margin: const EdgeInsets.all(8), // Provide some spacing around each square
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 96, 33, 243).withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the column's children vertically
            children: [
              // Conditionally display an image or text label
              if (imagePath != null)
                Image.asset(
                  imagePath,
                  width: 40, // Set an appropriate size for the image
                  height: 40,
                )
              else if (label != null)
                Text(label, style: TextStyle(fontSize: 16, color: Colors.white)),
              Text(value, style: infoValueStyle),
            ],
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround, // This will space out the squares evenly
      children: [
        // Replace "Wind" with an image
        infoSquare(
          imagePath: 'assets/weatherIcons/windy.png',
          value: weatherData != null ? "${weatherData!.windSpeed} km/h" : "Loading...",
        ),
        // Keep "Humidity" as text
        infoSquare(
          imagePath: 'assets/weatherIcons/drops.png',
          value: weatherData != null ? "${weatherData!.humidity}%" : "Loading...",
        ),
        // Replace "Pressure" with an image
        infoSquare(
          imagePath: 'assets/weatherIcons/pressure.png',
          value: weatherData != null ? "${weatherData!.pressure}hPa" : "Loading...",
        ),
      ],
    );
  }
}