import 'package:flutter/material.dart';
import 'package:flutter_vinet/modules/login/providers/login_provider.dart';
import 'package:flutter_vinet/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      child: Scaffold(
        backgroundColor: Color(myColors.primaryGreen()),
        body: Stack(
          children: [
            _buildLogo(context),
            _buildFormBox(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      alignment: Alignment.center,
      child: Container(
        height: 92.5,
        width: 200,
        child: Image.asset(
          "assets/images/splash/logo.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildFormBox(BuildContext context) {
    print(MediaQuery.of(context).size.height* 0.65);
    return ListView(
      children: [
        Consumer<LoginProvider>(
          builder: (context, loginProvider, _) => SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height* 0.65 < 430 ? 430 : MediaQuery.of(context).size.height* 0.65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  child: Form(
                    key: loginProvider.formGlobalKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildWelcomeTitle(),
                        _buildEmailInput(context),
                        _buildPasswordInput(context),
                        _buildForgotPassword(context),
                        _buildButtonLogin(),
                        _buildAlreadyHaveAccount(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeTitle() {
    return Container(
      margin: EdgeInsets.only(left: 43, top: 40),
      child: Text(
        "Welcome back",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 24,
          color: Color(myColors.secondaryTextColor()),
        ),
      ),
    );
  }

  Widget _buildEmailInput(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, loginProvider, _) => Container(
        margin: EdgeInsets.only(left: 43, top: 14),
        height: 88,
        width: 293,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Email",
              style: TextStyle(
                fontSize: 12,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            Widgets().textInput(
              controller: loginProvider.emailController,
              inputType: TextInputType.emailAddress,
              obscure: false,
              validator: (value) {
                if (loginProvider.isEmailValid(value!)) {
                  return null;
                }
                return "Invalid email";
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordInput(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, loginProvider, _) => Container(
        margin: EdgeInsets.only(left: 43, top: 14),
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

  Widget _buildForgotPassword(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 43),
      width: 293,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/fpassword'),
            child: Text(
              "Forgot Password?",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 11,
                decoration: TextDecoration.underline,
                decorationColor: Color(myColors.primaryGreen()),
                color: Color(myColors.primaryGreen()),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtonLogin() {
    return Consumer<LoginProvider>(
      builder: (context, loginProvider, _) => Container(
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.only(top: 33),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Widgets().arrowCircleButton(
              callback: () => loginProvider.onLogin(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlreadyHaveAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 9),
          child: Row(
            children: [
              Text(
                "Don't have an account ?  ",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/register', (route) => false),
                child: Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 13, color: Color(myColors.primaryGreen())),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
