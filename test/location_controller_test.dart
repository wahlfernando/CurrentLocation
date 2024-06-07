import 'dart:convert';
import 'package:current_location/src/config/api_config.dart';
import 'package:current_location/src/controllers/location_controller.dart';
import 'package:current_location/src/models/location_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class MockGeolocatorPlatform extends Mock implements GeolocatorPlatform {}
class MockClient extends Mock implements http.Client {}

void main() {
  group('LocationController', () {
    late MockGeolocatorPlatform mockGeolocator;
    late MockClient mockClient;
    late LocationController locationController;

    setUp(() {
      mockGeolocator = MockGeolocatorPlatform();
      mockClient = MockClient();
      locationController = LocationController();
    });

    test('fetchLocation returns a LocationModel if location services are enabled', () async {
      when(mockGeolocator.isLocationServiceEnabled()).thenAnswer((_) async => true);
      when(mockGeolocator.checkPermission()).thenAnswer((_) async => LocationPermission.whileInUse);
      
      GeolocatorPlatform.instance = mockGeolocator;

      final location = await locationController.fetchLocation();

      expect(location, isA<LocationModel>());
      expect(location.latitude, 51.509865);
      expect(location.longitude, -0.118092);
    });

    test('fetchLocation falls back to IP location if location services are disabled', () async {
      final responseBody = jsonEncode({
        'lat': 51.509865,
        'lon': -0.118092
      });

      when(mockGeolocator.isLocationServiceEnabled()).thenAnswer((_) async => false);

      when(mockClient.get(Uri.parse(ApiConfig.ipApiUrl)))
          .thenAnswer((_) async => http.Response(responseBody, 200));

      final location = await locationController.fetchLocation();

      expect(location, isA<LocationModel>());
      expect(location.latitude, 51.509865);
      expect(location.longitude, -0.118092);
    });

    test('fetchLocation throws an exception if the IP API call fails', () async {
      when(mockGeolocator.isLocationServiceEnabled()).thenAnswer((_) async => false);

      when(mockClient.get(Uri.parse(ApiConfig.ipApiUrl)))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(locationController.fetchLocation(), throwsException);
    });
  });
}
