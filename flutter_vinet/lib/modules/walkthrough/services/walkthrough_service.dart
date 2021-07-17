import 'package:flutter/material.dart';

class WTService {
  VoidCallback goToRegister(BuildContext context) => () => Navigator.pushNamedAndRemoveUntil(context, '/register', (route) => false);
  
}