import 'package:flutter/material.dart';
import 'package:flutter_vinet/modules/Starter/splash/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final splashServices = SplashServices();
    splashServices.navigateAfterDuration(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset("assets/images/splash/logo.png"),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 50),
            alignment: Alignment.bottomCenter,
            child: CircularProgressIndicator(),
          )
        ],
      ),
    );
  }
}