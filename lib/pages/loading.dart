import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weatherapp/services/weatherProvider.dart';
import 'package:provider/provider.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    // Safely access context after the widget tree is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setUp(context);
    });
  }

  Future<void> _setUp(BuildContext context) async {
    try {
      final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);

      // Fetch initial data
      await weatherProvider.fetchWeatherByCity(context, 'Toronto');
      await weatherProvider.fetchForecastByCity(context, 'Toronto');

      // Navigate to home screen after data is loaded
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      // Handle errors by showing a dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to load weather data: $e'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _setUp(context); // Retry fetching data
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 65, 13, 161),
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
