import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterProvider with ChangeNotifier, FormValidation {
  TextEditingController? nameController = TextEditingController();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? phoneController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? confirmController = TextEditingController();

  bool obscure = true;

  set setObscure(bool value) {
    this.obscure = value;
    notifyListeners();
  }

  void onSubmit(BuildContext context) {
    Navigator.pushNamed(
      context,
      '/otp',
    );
  }

  VoidCallback? goToLogin(BuildContext context) => () => {Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false)};
}

mixin FormValidation {
  bool isNameValid(String value) => value.toString().isNotEmpty;

  bool isEmailValid(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    return regex.hasMatch(value);
  }

  bool isPhoneValid(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);

    return regExp.hasMatch(value);
  }

  bool isPasswordValid(String value) => value.length >= 8;

  bool isPasswordMatch(String confirmPassword, String password) {
    return password.compareTo(confirmPassword) == 0;
  }
}
