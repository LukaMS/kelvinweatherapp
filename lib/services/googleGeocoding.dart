import 'dart:convert';
import 'package:http/http.dart' as http;

class GoogleGeocodingAPI {
  final String apiKey;

  GoogleGeocodingAPI({required this.apiKey});

  Future<Map<String, dynamic>> getLocationCoordinates(String city, String country) async {
    final apiUrl = 'https://maps.googleapis.com/maps/api/geocode/json?address=$city%20$country&key=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data['status'] == 'OK' && data['results'].length > 0) {
        final location = data['results'][0]['geometry']['location'];
        double lat = location['lat'];
        double lng = location['lng'];
        return {'latitude': lat, 'longitude': lng};
      } else {
        throw Exception('No location found for the provided city');
      }
    } else {
      throw Exception('Failed to fetch location data');
    }
  }
}