import 'package:flutter/material.dart';
import 'package:flutter_vinet/modules/Authentication/login/providers/login_provider.dart';
import 'package:flutter_vinet/widgets/widgets.dart';
import 'package:provider/provider.dart';

class NewPassword extends StatelessWidget {
  const NewPassword({Key? key}) : super(key: key);

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
            Consumer<LoginProvider>(
              builder: (context, loginProvider, _) => Form(
                key: loginProvider.formGlobalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(),
                    _buildInstruction(),
                    _buildPasswordInput(context),
                    _buildConfirmPasswordInput(context),
                    _buildButtonReset(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(top: 35, left: 24),
        height: 37,
        child: Text(
          "Create new password",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Color(myColors.secondaryTextColor()),
          ),
        ),
      ),
    );
  }

  Widget _buildInstruction() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(left: 24, top: 26),
        height: 40,
        width: 268,
        child: Text(
          "Your new password must be different than the last password",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: Color(myColors.secondaryTextColor()),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordInput(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, loginProvider, _) => Container(
        margin: EdgeInsets.only(left: 24, top: 36),
        height: 88,
        width: 293,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Password",
              style: TextStyle(
                fontSize: 12,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            Widgets().textInput(
              controller: loginProvider.passwordController,
              inputType: TextInputType.visiblePassword,
              obscure: loginProvider.obscure,
              icon: GestureDetector(
                onTap: () => loginProvider.setObscure = !loginProvider.obscure,
                child: Icon(
                  loginProvider.obscure ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                  color: Color(myColors.secondaryGrey()).withOpacity(0.3),
                ),
              ),
              validator: (value) {
                if (loginProvider.isPasswordValid(value!)) {
                  return null;
                }
                return "Your password must be at least 8 characters";
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordInput(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, loginProvider, _) => Container(
        margin: EdgeInsets.only(left: 24, top: 17),
        height: 88,
        width: 293,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Confirm Password",
              style: TextStyle(
                fontSize: 12,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            Widgets().textInput(
              controller: loginProvider.confirmController,
              obscure: loginProvider.obscure,
              inputType: TextInputType.visiblePassword,
              validator: (value) {
                if (loginProvider.isPasswordMatch(value!, loginProvider.passwordController!.text)) {
                  return null;
                }
                return "Password and Confirm Password must be match";
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonReset(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, loginProvider, _) => Container(
        margin: EdgeInsets.only(top: 45),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loginProvider.submitted
                ? Widgets().buttonWhenPressed()
                : Widgets().buttonSubmitGreen(
                    text: "Reset Password",
                    callback: () => loginProvider.resetPassword(context),
                  ),
          ],
        ),
      ),
    );
  }
}
