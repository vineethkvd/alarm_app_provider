import 'dart:convert';
import 'package:alarm_app_provider/utils/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/weather_model.dart';

class WheatherServices extends ChangeNotifier {
  WheatherModel? _wheatherModel;

  WheatherModel? get wheatherModel => _wheatherModel;
  bool? _isLoading;

  bool? get isLoading => _isLoading;
  String _error = "";

  Future<void> fetchWeatherDatabyCity(String city) async {
    String url =
        "${ApiKey.baseUrl}=${city}&appid=${ApiKey.apiKey}&units=metric";

    try {
      _isLoading = true;
      notifyListeners();

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        _wheatherModel = WheatherModel.fromJson(data);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}