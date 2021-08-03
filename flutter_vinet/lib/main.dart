import 'package:flutter/material.dart';
import 'package:flutter_vinet/config/routes/routes.dart';
import 'package:flutter_vinet/modules/Main%20Menu/main_menu.dart';
import 'package:flutter_vinet/modules/Starter/splash/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainMenu(),
      onGenerateRoute: Routes.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}