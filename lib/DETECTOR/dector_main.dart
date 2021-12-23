import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:splash_screen_view/splash_screen_view.dart';

import 'camera.dart';

class mysplashscreen extends StatefulWidget {
  @override
  _mysplashscreenState createState() => _mysplashscreenState();
}

class _mysplashscreenState extends State<mysplashscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "OBJECT DETECTOR",
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
        toolbarHeight: 100,
      ),
      body: SplashScreenView(
        duration: 2,
        imageSrc: "assets/scrolback.jpg",
        imageSize: 400,
        text: 'Loading..',
        navigateRoute: livecamera(),
      ),
    );
  }
}
