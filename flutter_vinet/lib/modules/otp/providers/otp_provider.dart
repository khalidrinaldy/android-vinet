import 'package:flutter/material.dart';

class OTPProvider with ChangeNotifier{
  TextEditingController? otpController1 = TextEditingController();
  TextEditingController? otpController2 = TextEditingController();
  TextEditingController? otpController3 = TextEditingController();
  TextEditingController? otpController4 = TextEditingController();
  FocusNode? otpFocus1 = FocusNode();
  FocusNode? otpFocus2 = FocusNode();
  FocusNode? otpFocus3 = FocusNode();
  FocusNode? otpFocus4 = FocusNode();
}