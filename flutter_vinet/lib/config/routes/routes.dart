import 'package:flutter/material.dart';
import 'package:flutter_vinet/models/customer_model.dart';
import 'package:flutter_vinet/modules/Authentication/login/screens/forgot_otp.dart';
import 'package:flutter_vinet/modules/Authentication/login/screens/forgot_password.dart';
import 'package:flutter_vinet/modules/Authentication/login/screens/login_screen.dart';
import 'package:flutter_vinet/modules/Authentication/login/screens/new_password.dart';
import 'package:flutter_vinet/modules/Authentication/otp/screens/otp_screen.dart';
import 'package:flutter_vinet/modules/Authentication/register/screens/register_screen.dart';
import 'package:flutter_vinet/modules/Authentication/register/screens/register_success.dart';
import 'package:flutter_vinet/modules/Main%20Menu/main_menu.dart';
import 'package:flutter_vinet/modules/Starter/splash/screens/splash_screen.dart';
import 'package:flutter_vinet/modules/Starter/walkthrough/screens/walkthrough_1.dart';
import 'package:flutter_vinet/modules/Starter/walkthrough/screens/walkthrough_2.dart';
import 'package:flutter_vinet/modules/Starter/walkthrough/screens/walkthrough_3.dart';
import 'package:flutter_vinet/modules/Sub%20Menu/area/screens/area_screen.dart';
import 'package:flutter_vinet/modules/Sub%20Menu/customers/screens/customer_screen.dart';
import 'package:flutter_vinet/modules/Sub%20Menu/customers/screens/detailCustomer_screen.dart';
import 'package:flutter_vinet/modules/Sub%20Menu/income/screens/income_screen.dart';
import 'package:flutter_vinet/modules/Sub%20Menu/payment/screens/payment_screen.dart';
import 'package:flutter_vinet/modules/Sub%20Menu/queue/screens/queue_screen.dart';
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
      case '/main-menu':
        return PageTransition(child: MainMenu(), type: PageTransitionType.bottomToTop);
      case '/payments':
        return PageTransition(child: PaymentScreen(), type: PageTransitionType.bottomToTop);
      case '/queue':
        return PageTransition(child: QueueScreen(), type: PageTransitionType.bottomToTop);
      case '/area':
        return PageTransition(child: AreaScreen(), type: PageTransitionType.bottomToTop);
      case '/income':
        return PageTransition(child: IncomeScreen(), type: PageTransitionType.bottomToTop);
      case '/customers':
        return PageTransition(child: CustomerScreen(), type: PageTransitionType.bottomToTop);
      case '/detail-customer':
        return PageTransition(child: DetailCustomer(customer: args as Customer,), type: PageTransitionType.bottomToTop);
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
