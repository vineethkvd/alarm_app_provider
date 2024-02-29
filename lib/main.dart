import 'package:alarm_app_provider/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/location_provider.dart';
import 'controller/location_service.dart';
import 'controller/wheather_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LocationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocationService(),
        ),
        ChangeNotifierProvider(
          create: (context) => WheatherServices(),
        ),
      ],
      child: MaterialApp(home: HomePage()),
    );
  }
}
