import 'dart:async';
import 'package:alarm_app_provider/views/widgets/weather_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../controller/alarm_provider.dart';
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
    context.read<alarmprovider>().initializeLocalNotification(context);
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });

    super.initState();
    context.read<alarmprovider>().getData();
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
        backgroundColor: Colors.indigo,
        title: const Text(
          'Alarmy ',
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
            Consumer<alarmprovider>(builder: (context, alarm, child) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.builder(
                    itemCount: alarm.modelist.length,
                    itemBuilder: (BuildContext, index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.1,
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
                                      CupertinoSwitch(
                                          value: (alarm.modelist[index]
                                                      .milliseconds! <
                                                  DateTime.now()
                                                      .microsecondsSinceEpoch)
                                              ? false
                                              : alarm.modelist[index].check,
                                          onChanged: (v) {
                                            alarm.editSwitch(index, v);

                                            alarm.cancelNotification(
                                                alarm.modelist[index].id!);
                                          }),
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
