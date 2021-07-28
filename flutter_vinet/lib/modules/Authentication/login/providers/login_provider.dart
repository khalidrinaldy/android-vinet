import 'dart:async';

import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier, FormValidation {
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? confirmController = TextEditingController();
  TextEditingController? otpController1 = TextEditingController();
  TextEditingController? otpController2 = TextEditingController();
  TextEditingController? otpController3 = TextEditingController();
  TextEditingController? otpController4 = TextEditingController();
  FocusNode? otpFocus1 = FocusNode();
  FocusNode? otpFocus2 = FocusNode();
  FocusNode? otpFocus3 = FocusNode();
  FocusNode? otpFocus4 = FocusNode();

  bool obscure = true;
  set setObscure(bool value) {
    this.obscure = value;
    notifyListeners();
  }

  bool _submitted = false;
  bool get submitted => this._submitted;
  set submitted(bool value) {
    this._submitted = value;
    notifyListeners();
  }

  void submitEmail(BuildContext context) {
    submitted = !this._submitted;
    Timer(Duration(milliseconds: 2500), () {
      submitted = !this._submitted;
      Navigator.pushReplacementNamed(context, '/fpassword-otp');
    });
  }

  submitOTP(BuildContext context) {
    if (otpController1!.text.isEmpty || otpController2!.text.isEmpty || otpController3!.text.isEmpty || otpController4!.text.isEmpty) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: new Text("Alert!!"),
          content: new Text("Please complete the otp"),
          actions: <Widget>[
            new ElevatedButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
    submitted = !this._submitted;
    Timer(Duration(milliseconds: 2500), () {
      submitted = !this._submitted;
      Navigator.pushReplacementNamed(context, '/new-password');
    });
  }

  void resetPassword(BuildContext context) {
    if (this.formGlobalKey.currentState!.validate()) {
      this.formGlobalKey.currentState!.save();
      submitted = !this._submitted;
      Timer(Duration(milliseconds: 2500), () {
        submitted = !this._submitted;
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      });
    }
  }

  void onLogin(BuildContext context) {
    if (this.formGlobalKey.currentState!.validate()) {
      this.formGlobalKey.currentState!.save();
      Navigator.pushNamedAndRemoveUntil(context, '/main-menu', (route) => false);
    }
  }
}

mixin FormValidation {
  bool isEmailValid(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    return regex.hasMatch(value);
  }

  bool isPasswordValid(String value) => value.length >= 8;

  bool isPasswordMatch(String confirmPassword, String password) {
    return password.compareTo(confirmPassword) == 0;
  }
}
