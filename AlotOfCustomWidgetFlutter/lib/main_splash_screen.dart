import 'package:flutter/material.dart';
import 'package:flutter_app12/main.dart';
import 'package:splashscreen/splashscreen.dart';


class MainSplashScreen extends StatefulWidget {
  @override
  _MainSplashScreenState createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SplashScreen(
          backgroundColor: Colors.blueAccent,
          image: Image.asset('images/s1.jpg'),
          photoSize: 180,
          seconds: 3,
          navigateAfterSeconds: MyHomePage(),
          title: Text("Splash Screen Tutorial!"),
          loaderColor: Colors.lightGreen,
          loadingText: Text("Getting Page Ready!"),
        ),
      ),
    );
  }
}
