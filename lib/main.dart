import 'package:flutter/material.dart';
import 'package:weatherapp/pages/loading.dart';
import 'package:weatherapp/pages/home.dart';
import 'package:weatherapp/pages/search.dart';
import 'package:weatherapp/pages/settings.dart';
import 'package:weatherapp/services/fiveDayWeatherAPI.dart';
import 'package:weatherapp/services/settingsProvider.dart';
import 'package:weatherapp/services/userPreferences.dart';
import 'package:weatherapp/services/weatherProvider.dart';
import 'package:weatherapp/services/weatherAPI.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
  await dotenv.load(fileName: ".env");
  final String apiKey = dotenv.env['API_KEY']!;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
        ChangeNotifierProvider(
          create: (context) => WeatherProvider(
            weatherService: WeatherAPI(
              apiKey: apiKey,
              baseUrl: "https://api.openweathermap.org/data/2.5/weather",
            ),
            forecastService: ForecastAPI(
              apiKey: apiKey,
              baseUrl: "https://api.openweathermap.org/data/2.5/forecast",
            ),
          ),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const Loading(),
          '/home': (context) => const newHome(),
          '/search': (context) => const Search(),
          '/settings': (context) => const Settings(),
        },
      ),
    ),
  );
}

