import 'package:flutter/material.dart';
import 'package:flutter_vinet/config/routes/routes.dart';
import 'package:flutter_vinet/modules/Starter/splash/screens/splash_screen.dart';
import 'package:flutter_vinet/provider/server_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ServerProvider()),
      ],
      child: MaterialApp(
        home: SplashScreen(),
        onGenerateRoute: Routes.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}