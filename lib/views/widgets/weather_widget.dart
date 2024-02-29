import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../controller/location_provider.dart';
import '../../controller/wheather_services.dart';

class WheaterData extends StatefulWidget {
  const WheaterData({super.key});

  @override
  State<WheaterData> createState() => _WheaterDataState();
}

class _WheaterDataState extends State<WheaterData> {
  @override
  void initState() {
    // TODO: implement initState
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    locationProvider.determinePosition().then((value) {
      var city = locationProvider.currentLocationName!.locality;
      if (city != null) {
        Provider.of<WheatherServices>(context, listen: false)
            .fetchWeatherDatabyCity(city);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loacationProvider = Provider.of<LocationProvider>(context);
    final wheatherServices = Provider.of<WheatherServices>(context);
    return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer<LocationProvider>(
              builder: (context, loacationProvider, child) => Text(
                "Current Location is ${loacationProvider.currentLocationName != null ? loacationProvider.currentLocationName!.locality ?? "Unknown" : "Fetching..."}",
                style: TextStyle(fontSize: 25),
              ),
            ),
            Consumer<WheatherServices>(
              builder: (context, loacationProvider, child) => Text(
                "Current Location is ${wheatherServices.wheatherModel != null && wheatherServices.wheatherModel!.clouds != null ? wheatherServices.wheatherModel!.clouds!.all : "Fetching..."}",
                style: TextStyle(fontSize: 25),
              ),
            )
          ],
        ));
  }
}
