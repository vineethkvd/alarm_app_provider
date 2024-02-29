import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService extends ChangeNotifier {
  Future<Placemark?> getLocationName(Position? position) async {
    if (position != null) {
      try {
        final List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
        return placemarks.isNotEmpty ? placemarks.first : null;
      } catch (e) {
        print("Error fetching location name: $e");
        return null;
      }
    }
    return null; // Added return null if position is null
  }
}