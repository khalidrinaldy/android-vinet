import 'package:flutter/material.dart';
import 'package:flutter_vinet/modules/Authentication/login/providers/login_provider.dart';
import 'package:flutter_vinet/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Forgot Password",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Color(myColors.darkGreen()),
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(myColors.secondaryWhiteScreen()),
          elevation: 0,
          iconTheme: IconThemeData(color: Color(myColors.darkGreen())),
        ),
        body: ListView(
          children: [
            _buildTitle(),
            _buildInstruction(),
            _buildImage(),
            _buildEmailForm(context),
            _buildSendButton(context),
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
        "Forgot your password?",
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
          "Enter your registered email below to receive OTP code to reset password",
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
        "assets/images/forgot password/forgot.png",
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _buildEmailForm(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, loginProvider, _) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 46,
            child: Form(
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(myColors.secondaryGrey()).withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(myColors.primaryRed()).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  filled: true,
                  fillColor: Color(myColors.secondaryGrey()).withOpacity(0.15),
                  hintText: "Email",
                  hintStyle: TextStyle(
                    fontFamily: "Nunito Sans",
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
                controller: loginProvider.emailController,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSendButton(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, loginProvider, _) => Container(
        margin: EdgeInsets.only(top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loginProvider.submitted
                ? Widgets().buttonWhenPressed()
                : Widgets().buttonSubmitGreen(
                    text: "Send",
                    callback: () => loginProvider.submitEmail(context),
                  ),
          ],
        ),
      ),
    );
  }
}
