import 'package:flutter/material.dart';
import 'package:flutter_vinet/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "OTP",
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
      backgroundColor: Color(myColors.secondaryWhiteScreen()),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
            height: 180,
            width: 180,
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/otp/otp.png',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 31),
            height: 37,
            alignment: Alignment.center,
            child: Text(
              "Verification Code",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 21,
                color: Color(myColors.secondaryTextColor()),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 24),
              width: 285,
              height: 37,
              child: Text(
                "We have sent the code verification to Your WhatsApp Number",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Color(myColors.secondaryTextColor()),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 40),
              height: 46,
              width: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Widgets().inputOTP(context),
                  Widgets().inputOTP(context),
                  Widgets().inputOTP(context),
                  Widgets().inputOTP(context),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
            alignment: Alignment.center,
            child: Widgets().buttonSubmitGreen(
              text: "Submit",
              callback: () {
                Navigator.pushNamed(context, '/register-success');
              },
            ),
          ),
        ],
      ),
    );
  }
}
