import 'package:alarm_app_provider/views/alarm_home.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    moveToHome();
    super.initState();
  }

  moveToHome() async {
    await Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AlarmHome(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Image.asset(
          "assets/images/app_logo.png",
          height: 42,
          width: 139,
        ),
      ),
    );
  }
}
