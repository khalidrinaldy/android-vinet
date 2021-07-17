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
        onPressed: callback
      ),
    );
  }

  Widget textInput({TextEditingController? controller, bool? obscure}) {
    return TextField(
      controller: controller,
      obscureText: obscure!,
      decoration: InputDecoration(
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
        stepWidth: 10,
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

  Widget buttonSubmitGreen({void callback}) {
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
          "Submit",
          style: TextStyle(
            fontFamily: "Rubik",
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(myColors.secondaryTextColor()),
          ),
        ),
        onPressed: () => callback,
      ),
    );
  }

  Widget searchBox({String? thingToSearch}) {
    return Container(
      width: 310,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 4,
            spreadRadius: -3,
            offset: Offset(0,2),
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            size: 20,
            color: Colors.black.withOpacity(0.5),
          ),
          hintText: "Search $thingToSearch",
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
