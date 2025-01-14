import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:weatherapp/pages/home.dart';
import 'package:weatherapp/services/googleGeocoding.dart';
import 'package:weatherapp/services/weatherProvider.dart';
import 'package:provider/provider.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<CustomSearchBar> {
  late TextEditingController _textEditingController;
  late GoogleMapsPlaces _placesService;
  List<Prediction> _predictions = [];
  late GoogleGeocodingAPI _geocodingAPI; // Instance of GoogleGeocodingAPI

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _placesService = GoogleMapsPlaces(
      apiKey: 'AIzaSyD9LTMtd33dMDIl5eIK6se03yRyDXIa-J8', // Replace with your Google Maps API key
    );
    _geocodingAPI = GoogleGeocodingAPI(apiKey: 'AIzaSyD9LTMtd33dMDIl5eIK6se03yRyDXIa-J8'); // Initialize GoogleGeocodingAPI
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(
              labelText: 'Enter city name',
              suffixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              // Perform autocomplete using Google Places API
              _autocompletePlaces(value);
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _predictions.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_predictions[index].description!),
                onTap: () async {
                  //Get City name from the selected prediction and update weather data
                  String city = _predictions[index].terms.first.value;
                  String country = _predictions[index].terms.last.value;
                  //Get coordinates from Google Geocoding API
                  Map<String, dynamic> coordinates = await _geocodingAPI.getLocationCoordinates(city, country);
                  double latitude = coordinates['latitude'];
                  double longitude = coordinates['longitude'];

                  await weatherProvider.fetchWeatherByLocation(context, latitude, longitude);
                  await weatherProvider.fetchForecastByLocation(context, latitude, longitude);

                  //Pop back to the home page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const newHome()),
                  );
                  _textEditingController.text = _predictions[index].description!;
                },
              );
            },
          ),
        ),
      ],
    );
  }

  //User Google Places API to perform autocomplete
  Future<void> _autocompletePlaces(String input) async {
  final response = await _placesService.autocomplete(input);
  if (response.isOkay) {
    setState(() {
      _predictions = response.predictions
          .where((prediction) =>
              prediction.types.contains("locality") ||
              prediction.types.contains("administrative_area_level_2"))
          .toList();
    });
  } else {
    // Handle error
    print('Autocomplete request failed: ${response.errorMessage}');
  }
}
}