import 'dart:async';
import 'package:flutter/material.dart';

class SplashServices {
  int _duration = 5;

  void navigateAfterDuration(BuildContext context) {
    Timer(Duration(seconds: _duration), () =>
      Navigator.pushNamedAndRemoveUntil(context, '/walkthrough1', (route) => false)
    );
  }
}