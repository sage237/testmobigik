import 'dart:async';

import 'package:flutter/material.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool newuser = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateToNextScreen();
  }

  ///This Function delays for three seconds to display splash screen content and  then navigate to the home screen
  void navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/images/logo.jpg", width: 270),
              const Text("Loading"),
            ],
          ),
        ),
      ),
    );
  }
}
