import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/location_model.dart';
import '../config/api_config.dart';

class LocationController {
  Future<LocationModel> fetchLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return await _fetchLocationFromIP();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return await _fetchLocationFromIP();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return await _fetchLocationFromIP();
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return LocationModel(latitude: position.latitude, longitude: position.longitude);
  }

  Future<LocationModel> _fetchLocationFromIP() async {
    final response = await http.get(Uri.parse(ApiConfig.ipApiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return LocationModel(latitude: data['lat'], longitude: data['lon']);
    } else {
      throw Exception('Failed to load location from IP API');
    }
  }
}
