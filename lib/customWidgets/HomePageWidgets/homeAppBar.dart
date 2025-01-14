import 'package:flutter/material.dart';
import 'package:weatherapp/customWidgets/HomePageWidgets/customMenu.dart';
import 'package:weatherapp/customWidgets/buttons/searchButton.dart';
import 'package:weatherapp/customWidgets/buttons/settingsButton.dart';
import 'package:weatherapp/services/weatherModel.dart';

// ignore: camel_case_types
class homeAppBar extends StatelessWidget {
  
  WeatherModel? weatherData;

  homeAppBar({Key? key, this.weatherData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        leading: settingsButton(weatherData: weatherData,),
        title: CustomMenu(weatherData: weatherData,),
        centerTitle: true,
        actions: const [
          searchButton(),
        ],
      );
  }
}