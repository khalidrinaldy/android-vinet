import 'package:flutter/material.dart';
import 'package:flutter_vinet/modules/Authentication/login/providers/login_provider.dart';
import 'package:flutter_vinet/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ForgotOTP extends StatelessWidget {
  const ForgotOTP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(myColors.secondaryWhiteScreen()),
          elevation: 0,
          iconTheme: IconThemeData(color: Color(myColors.darkGreen())),
        ),
        body: ListView(
          children: [
            _buildTitle(),
            _buildInstruction(),
            _buildImage(),
            _buildOTPInput(context),
            _buildButtonSubmit(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      margin: EdgeInsets.only(top: 35),
      height: 37,
      alignment: Alignment.center,
      child: Text(
        "Email has been sent!",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: Color(myColors.secondaryTextColor()),
        ),
      ),
    );
  }

  Widget _buildInstruction() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.only(top: 16),
        height: 37,
        width: 285,
        child: Text(
          "Please check your inbox and look for OTP code then submit the code below",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: Color(myColors.secondaryTextColor()),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      margin: EdgeInsets.only(top: 13),
      height: 180,
      width: 180,
      alignment: Alignment.center,
      child: Image.asset(
        "assets/images/forgot password/email_sent.png",
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _buildOTPInput(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, loginProvider, _) => Align(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.only(top: 40),
          height: 46,
          width: 250,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Widgets().inputOTP(
                context,
                controller: loginProvider.otpController1,
                currentFocus: loginProvider.otpFocus1,
                nextFocus: loginProvider.otpFocus2,
              ),
              Widgets().inputOTP(
                context,
                controller: loginProvider.otpController2,
                currentFocus: loginProvider.otpFocus2,
                nextFocus: loginProvider.otpFocus3,
              ),
              Widgets().inputOTP(
                context,
                controller: loginProvider.otpController3,
                currentFocus: loginProvider.otpFocus3,
                nextFocus: loginProvider.otpFocus4,
              ),
              Widgets().inputOTP(
                context,
                controller: loginProvider.otpController4,
                currentFocus: loginProvider.otpFocus4,
                nextFocus: loginProvider.otpFocus4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonSubmit(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, loginProvider, _) => Container(
        margin: EdgeInsets.only(top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loginProvider.submitted
                ? Widgets().buttonWhenPressed()
                : Widgets().buttonSubmitGreen(
                    text: "Submit",
                    callback: () => loginProvider.submitOTP(context),
                  ),
          ],
        ),
      ),
    );
  }
}
