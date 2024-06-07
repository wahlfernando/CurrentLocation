import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/location_model.dart';

class MapView extends StatelessWidget {
  final LocationModel location;

  const MapView({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: LatLng(location.latitude, location.longitude),
        zoom: 14.0,
      ),
      markers: {
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: LatLng(location.latitude, location.longitude),
        ),
      },
    );
  }
}
