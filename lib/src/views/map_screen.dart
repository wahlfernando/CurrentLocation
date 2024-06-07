// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../controllers/location_controller.dart';
import '../models/location_model.dart';
import 'map_view.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final LocationController _controller = LocationController();
  late Future<LocationModel> _locationFuture;

  @override
  void initState() {
    super.initState();
    _locationFuture = _controller.fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Localização Atual'),
      ),
      body: FutureBuilder<LocationModel>(
        future: _locationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao obter localização'));
          } else if (snapshot.hasData) {
            return MapView(location: snapshot.data!);
          } else {
            return const Center(child: Text('Nenhuma localização disponível'));
          }
        },
      ),
    );
  }
}
