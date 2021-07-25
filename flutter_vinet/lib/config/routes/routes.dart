import 'package:flutter/material.dart';
import 'package:flutter_vinet/modules/login/screens/forgot_otp.dart';
import 'package:flutter_vinet/modules/login/screens/forgot_password.dart';
import 'package:flutter_vinet/modules/login/screens/login_screen.dart';
import 'package:flutter_vinet/modules/login/screens/new_password.dart';
import 'package:flutter_vinet/modules/otp/screens/otp_screen.dart';
import 'package:flutter_vinet/modules/register/screens/register_screen.dart';
import 'package:flutter_vinet/modules/register/screens/register_success.dart';
import 'package:flutter_vinet/modules/splash/screens/splash_screen.dart';
import 'package:flutter_vinet/modules/walkthrough/screens/walkthrough_1.dart';
import 'package:flutter_vinet/modules/walkthrough/screens/walkthrough_2.dart';
import 'package:flutter_vinet/modules/walkthrough/screens/walkthrough_3.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/walkthrough1':
        return PageTransition(
          child: WalkThrough1(),
          type: PageTransitionType.bottomToTop,
          curve: Curves.easeInOut,
        );
      case '/walkthrough2':
        return PageTransition(
          child: WalkThrough2(),
          type: PageTransitionType.rightToLeft,
          curve: Curves.easeInOut,
        );
      case '/walkthrough3':
        return PageTransition(child: WalkThrough3(), type: PageTransitionType.rightToLeft);
      case '/login':
        return PageTransition(child: LoginScreen(), type: PageTransitionType.bottomToTop);
      case '/register':
        return PageTransition(child: RegisterScreen(), type: PageTransitionType.bottomToTop, duration: Duration(milliseconds: 200));
      case '/otp':
        return PageTransition(child: OTPScreen(), type: PageTransitionType.rightToLeft);
      case '/register-success':
        return PageTransition(child: RegisterSuccess(), type: PageTransitionType.rightToLeft);
      case '/fpassword':
        return PageTransition(child: ForgotPassword(), type: PageTransitionType.rightToLeft);
      case '/fpassword-otp':
        return PageTransition(child: ForgotOTP(), type: PageTransitionType.rightToLeft);
      case '/new-password':
        return PageTransition(child: NewPassword(), type: PageTransitionType.rightToLeft);
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Center(
          child: Text("Error Page"),
        ),
      );
    });
  }
}
