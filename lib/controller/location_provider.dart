import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'location_service.dart';

class LocationProvider extends ChangeNotifier {
  Position? _currentPosition;
  LocationPermission? permission;

  Position? get currentPosition => _currentPosition;
  final LocationService _locationService = LocationService();
  Placemark? _currentLocationName;

  Placemark? get currentLocationName => _currentLocationName;

  Future<void> determinePosition() async {
    bool serviceEnabled;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _currentPosition = null;
      notifyListeners();
    }
    permission = await Geolocator.checkPermission();
    notifyListeners();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _currentPosition = null;
        notifyListeners();
      }
    }
    if (permission == LocationPermission.deniedForever) {
      _currentPosition = null;
      notifyListeners();
    }
    _currentPosition = await Geolocator.getCurrentPosition();
    print(_currentPosition);
    _currentLocationName =
    await _locationService.getLocationName(_currentPosition);
    notifyListeners();
  }
}