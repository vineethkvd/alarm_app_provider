import 'dart:async';
import 'package:alarm_app_provider/views/widgets/weather_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../controller/alarm_provider.dart';
import '../controller/location_provider.dart';
import '../controller/wheather_services.dart';
import 'add_alarm.dart';

class AlarmHome extends StatefulWidget {
  const AlarmHome({super.key});

  @override
  State<AlarmHome> createState() => _AlarmHomeState();
}

class _AlarmHomeState extends State<AlarmHome> {
  bool value = false;

  @override
  void initState() {
    final locationProvider =
    Provider.of<LocationProvider>(context, listen: false);
    locationProvider.determinePosition().then((value) {
      var city = locationProvider.currentLocationName!.locality;
      if (city != null) {
        Provider.of<WheatherServices>(context, listen: false)
            .fetchWeatherDatabyCity(city);
      }
    });
    context.read<Alarmprovider>().initializeLocalNotification(context);
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });

    super.initState();
    context.read<Alarmprovider>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEFF5),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.indigo,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddAlarm()));
          },
          label: Row(
            children: [
              Icon(Icons.add, color: Colors.white),
              SizedBox(
                width: 5,
              ),
              Text(
                "Add alarm",
                style: TextStyle(color: Colors.white),
              )
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.indigo,
        title: const Text(
          'Alarm',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black.withOpacity(0.8)),
                height: MediaQuery.of(context).size.height * 0.13,
                child: Column(
                  children: [
                    const WheaterData(),
                    Center(
                        child: Text(
                      DateFormat.yMEd().add_jms().format(
                            DateTime.now(),
                          ),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    )),
                  ],
                ),
              ),
            ),
            Consumer<Alarmprovider>(builder: (context, alarm, child) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.builder(
                    itemCount: alarm.modelist.length,
                    itemBuilder: (BuildContext, index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.11,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            alarm.modelist[index].dateTime!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              alarm.modelist[index].label
                                                          .toString() !=
                                                      null
                                                  ? alarm.modelist[index].label
                                                      .toString()!
                                                  : "No label added",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                      IconButton(onPressed: () {
                                        Provider.of<Alarmprovider>(context, listen: false)
                                            .deleteAlarm(index, context);
                                      }, icon: Icon(CupertinoIcons.delete))
                                    ],
                                  ),
                                  Text(alarm.modelist[index].when!)
                                ],
                              ),
                            ),
                          ));
                    }),
              );
            }),
          ],
        ),
      ),
    );
  }
}
