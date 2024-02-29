import 'package:alarm_app_provider/views/widgets/weather_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/location_provider.dart';
import '../controller/location_service.dart';
import '../controller/wheather_services.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(child: Column(children: [WheaterData()])),
      ),
    );
  }
}
