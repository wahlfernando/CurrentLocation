// ignore_for_file: library_private_types_in_public_api

import 'package:current_location/src/config/i18n/locale_keys.dart';
import 'package:flutter/material.dart';
import '../controllers/location_controller.dart';
import '../models/location_model.dart';
import 'map_view.dart';
import 'package:i18n_extension/i18n_widget.dart';

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

  void _changeLanguage(Locale locale) {
    I18n.of(context).locale = locale;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return I18n(
      child: Scaffold(
        appBar: AppBar(
          title: Text("title".i18n),
          actions: [
            IconButton(
              icon: const Icon(Icons.language),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("change_language".i18n),
                    actions: [
                      TextButton(
                        onPressed: () {
                          _changeLanguage(const Locale('en', 'US'));
                          Navigator.of(context).pop();
                        },
                        child: const Text('English'),
                      ),
                      TextButton(
                        onPressed: () {
                          _changeLanguage(const Locale('pt', 'BR'));
                          Navigator.of(context).pop();
                        },
                        child: const Text('Português'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        body: FutureBuilder<LocationModel>(
          future: _locationFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("error".i18n));
            } else if (snapshot.hasData) {
              return MapView(location: snapshot.data!);
            } else {
              return Center(child: Text("no_location".i18n));
            }
          },
        ),
      ),
    );
  }
}
