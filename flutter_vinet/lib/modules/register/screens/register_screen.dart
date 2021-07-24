import 'package:flutter/material.dart';
import 'package:flutter_vinet/modules/register/providers/register_provider.dart';
import 'package:flutter_vinet/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final widgets = Widgets();
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterProvider(),
      child: Scaffold(
        body: ListView(
          children: [
            registerForm(),
            submitButton(),
            alreadyHaveAccount(),
          ],
        ),
      ),
    );
  }

  Widget registerForm() {
    return Consumer<RegisterProvider>(
      builder: (context, registerProvider, _) => Form(
        key: formGlobalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //TITLE
            Container(
              margin: EdgeInsets.only(left: 25, top: 45, bottom: 25),
              child: Text(
                "Create New Account",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: Color(myColors.secondaryTextColor()),
                ),
              ),
            ),

            //FULL NAME INPUT
            Container(
              margin: EdgeInsets.only(left: 25),
              width: 293,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Full Name",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                  widgets.textInput(
                    controller: registerProvider.nameController,
                    obscure: false,
                    inputType: TextInputType.text,
                    validator: (value) {
                      if (registerProvider.isNameValid(value!)) {
                        return null;
                      }
                      return "Please fill this form";
                    },
                  ),
                ],
              ),
            ),

            //EMAIL INPUT
            Container(
              margin: EdgeInsets.only(left: 25),
              width: 293,
              height: 88,
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
                  widgets.textInput(
                    controller: registerProvider.emailController,
                    obscure: false,
                    inputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (registerProvider.isEmailValid(value!)) {
                        return null;
                      }
                      return "Input a valid email";
                    },
                  ),
                ],
              ),
            ),

            //PHONE NUMBER INPUT
            Container(
              margin: EdgeInsets.only(left: 25),
              width: 293,
              height: 88,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Phone Number",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                  widgets.textInput(
                      controller: registerProvider.phoneController,
                      obscure: false,
                      inputType: TextInputType.phone,
                      validator: (value) {
                        if (registerProvider.isPhoneValid(value!)) {
                          return null;
                        }
                        return "Input a valid phone number";
                      }),
                ],
              ),
            ),

            //PASSWORD INPUT
            Container(
              margin: EdgeInsets.only(left: 25),
              width: 293,
              height: 88,
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
                  widgets.textInput(
                    controller: registerProvider.passwordController,
                    obscure: registerProvider.obscure,
                    inputType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (registerProvider.isPasswordValid(value!)) {
                        return null;
                      }
                      return "Your password must be at least 8 characters";
                    },
                    icon: GestureDetector(
                      onTap: () => registerProvider.setObscure = !registerProvider.obscure,
                      child: Icon(
                        registerProvider.obscure ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                        color: Color(myColors.secondaryGrey()).withOpacity(0.3),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //CONFIRM PASSWORD INPUT
            Container(
              margin: EdgeInsets.only(left: 25),
              width: 293,
              height: 88,
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
                  widgets.textInput(
                    controller: registerProvider.confirmController,
                    obscure: registerProvider.obscure,
                    inputType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (registerProvider.isPasswordMatch(value!, registerProvider.passwordController!.text)) {
                        return null;
                      }
                      return "Password and Confirm Password must be match";
                    }
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget submitButton() {
    return Consumer<RegisterProvider>(
      builder: (context, registerProvider, _) => Container(
        margin: EdgeInsets.only(top: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widgets.buttonSubmitGreen(callback: () {
              if (formGlobalKey.currentState!.validate()) {
                formGlobalKey.currentState!.save();
                registerProvider.onSubmit(context);
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget alreadyHaveAccount() {
    return Consumer<RegisterProvider>(
      builder: (context, registerProvider, _) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 23),
            child: Row(
              children: [
                Text(
                  "Already have an account ? ",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                GestureDetector(
                  onTap: registerProvider.goToLogin(context),
                  child: Text(
                    "Sign In",
                    style: TextStyle(fontSize: 13, color: Color(myColors.primaryGreen())),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
