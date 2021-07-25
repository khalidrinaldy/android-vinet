import 'package:flutter/material.dart';
import 'package:flutter_vinet/widgets/widgets.dart';

class RegisterSuccess extends StatelessWidget {
  const RegisterSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(myColors.secondaryWhiteScreen()),
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 53),
              alignment: Alignment.center,
              child: Text(
                "Registration Success!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Color(myColors.secondaryTextColor()),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              width: 285,
              height: 60,
              alignment: Alignment.center,
              child: Text(
                "Please wait a few moments before logging in. We are currently processing your registration. We will inform you of a success message to your WhatsApp and Email",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Color(myColors.secondaryTextColor()),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              height: 220,
              width: 220,
              child: Image.asset(
                "assets/images/registration/success.png",
                fit: BoxFit.fill,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 35),
              child: Widgets().buttonSubmitGreen(
                text: "Proceed",
                callback: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
