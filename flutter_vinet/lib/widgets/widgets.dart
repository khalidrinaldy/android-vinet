import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vinet/config/themes/mycolors.dart';

final myColors = MyColors();

class Widgets {
  Widget smallLoginButton(BuildContext context) {
    return Container(
      width: 100,
      height: 28,
      child: ElevatedButton(
        child: Text(
          "Login",
          style: TextStyle(fontSize: 11),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(myColors.primaryGreen())),
        ),
        onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false),
      ),
    );
  }

  Widget dotProgress({int? color}) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Color(color!).withOpacity(0.5),
      ),
    );
  }

  Widget nextButton({BuildContext? context, String? route}) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context!, route!),
      child: Row(
        children: [
          Text(
            "Lanjut",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 18,
          ),
        ],
      ),
    );
  }

  Widget arrowCircleButton({VoidCallback? callback}) {
    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 0,
            offset: Offset(0, 4),
            color: Colors.black.withOpacity(0.25),
          ),
        ],
        borderRadius: BorderRadius.circular(27.5),
      ),
      alignment: Alignment.center,
      child: ElevatedButton(
          child: Icon(
            Icons.arrow_forward,
            size: 28,
            color: Colors.white,
          ),
          style: ButtonStyle(
            alignment: Alignment.center,
            backgroundColor: MaterialStateProperty.all(
              Color(myColors.primaryGreen()),
            ),
            shape: MaterialStateProperty.all(CircleBorder()),
            minimumSize: MaterialStateProperty.all(Size(double.infinity, double.infinity)),
          ),
          onPressed: callback),
    );
  }

  Widget textInput({
    TextEditingController? controller,
    bool? obscure,
    TextInputType? inputType,
    String? Function(String?)? validator,
    Widget? icon,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 70,
        maxWidth: 293,
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure!,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Color(myColors.secondaryGrey()).withOpacity(0.3),
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Color(myColors.secondaryGrey()).withOpacity(0.3),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.3),
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Color(myColors.primaryRed()).withOpacity(0.3),
              width: 1,
            ),
          ),
          suffixIcon: icon,
        ),
        textInputAction: TextInputAction.done,
        keyboardType: inputType,
        validator: validator,
      ),
    );
  }

  Widget inputOTP(BuildContext context, {TextEditingController? controller, FocusNode? currentFocus, FocusNode? nextFocus}) {
    return Container(
      height: 46,
      width: 46,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(myColors.secondarySoftGreen()),
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 0,
            offset: Offset(0, 2),
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
      child: IntrinsicWidth(
        stepHeight: 10,
        stepWidth: 2,
        child: TextField(
          controller: controller,
          style: TextStyle(
            fontFamily: "Nunito Sans",
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            border: UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
            counterText: "",
          ),
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).requestFocus(nextFocus);
            }
          },
          focusNode: currentFocus,
        ),
      ),
    );
  }

  Widget buttonSubmitGreen({String? text, VoidCallback? callback}) {
    return Container(
      width: 288,
      height: 42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 0,
            offset: Offset(0, 4),
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(myColors.primaryGreen())),
          alignment: Alignment.center,
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: Text(
          text!,
          style: TextStyle(
            fontFamily: "Rubik",
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(myColors.secondaryTextColor()),
          ),
        ),
        onPressed: callback,
      ),
    );
  }

  Widget buttonWhenPressed() {
    return Container(
        width: 288,
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(myColors.darkGreen()).withOpacity(0.7),
          borderRadius: BorderRadius.circular(10),
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 4,
              spreadRadius: 0,
              offset: Offset(0, 4),
              color: Colors.black.withOpacity(0.25),
            ),
          ],
        ),
        child: CircularProgressIndicator(
          color: Color(myColors.secondaryTextColor()),
        ));
  }

  Widget searchBox({String? thingToSearch, TextEditingController? searchController, void Function(String)? search}) {
    return Container(
      width: 225,
      height: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 4,
            spreadRadius: -3,
            offset: Offset(0, 2),
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
      child: TextFormField(
        onFieldSubmitted: search!,
        controller: searchController,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.all(8),
          prefixIcon: Icon(
            Icons.search,
            size: 16,
            color: Colors.black.withOpacity(0.5),
          ),
          hintText: "Search $thingToSearch",
          hintStyle: TextStyle(fontSize: 11),
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget incomeCard({Color? color, Icon? icon, String? title, String? amount}) {
    return Container(
      width: 120,
      height: 90,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 1,
            color: color!.withOpacity(0.25),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          icon!,
          Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "$title\n\n",
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(myColors.secondaryTextColor()),
                  ),
                ),
                TextSpan(
                  text: amount,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 8,
                    color: Color(myColors.secondaryTextColor()),
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget smallButton({Color? color, Widget? icon, String? text, VoidCallback? onPressed}) {
    return Container(
      height: 15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 0,
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon!,
            SizedBox(
              width: 5,
            ),
            Text(
              text!,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
