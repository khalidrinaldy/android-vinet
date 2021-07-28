import 'package:flutter/material.dart';
import 'package:flutter_vinet/config/themes/mycolors.dart';
import 'package:flutter_vinet/modules/Starter/walkthrough/services/walkthrough_service.dart';
import 'package:flutter_vinet/widgets/widgets.dart';

class WalkThrough3 extends StatelessWidget {
  WalkThrough3({ Key? key }) : super(key: key);

  final widgets = Widgets();
  final myColors = MyColors();
  final wtService = WTService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 17),
                  height: 200,
                  width: 200,
                  child: Image.asset(
                    "assets/images/walkthrough/walkthrough_3.png",
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 17),
                  alignment: Alignment.center,
                  child: Text(
                    "Yuk Mulai !",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 50),
                  width: 255,
                  height: 60,
                  alignment: Alignment.center,
                  child: Text(
                    "Mari mulai kelola usaha dan pelanggan anda.",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 68,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widgets.dotProgress(color: myColors.primaryGrey()),
                      widgets.dotProgress(color: myColors.primaryGrey()),
                      widgets.dotProgress(color: myColors.darkGreen()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                margin: EdgeInsets.only(bottom: 20),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    widgets.arrowCircleButton(callback: wtService.goToRegister(context)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}