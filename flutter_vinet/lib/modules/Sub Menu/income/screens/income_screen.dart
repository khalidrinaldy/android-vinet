import 'package:flutter/material.dart';
import 'package:flutter_vinet/models/income_model.dart';
import 'package:flutter_vinet/models/server_model.dart';
import 'package:flutter_vinet/modules/Sub%20Menu/income/widgets/chart.dart';
import 'package:flutter_vinet/provider/server_provider.dart';
import 'package:flutter_vinet/widgets/widgets.dart';
import 'package:provider/provider.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({Key? key}) : super(key: key);

  @override
  _IncomeScreenState createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  Future? futureServer;
  Income? income;
  List<IncomeDummy> incomeDummys = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureServer = Provider.of<ServerProvider>(context, listen: false).getServerList();
    if (incomeDummys.length == 0) {
      incomeDummys.addAll([
        IncomeDummy(15, "March"),
        IncomeDummy(25, "April"),
        IncomeDummy(10, "May"),
        IncomeDummy(30, "June"),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Income",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return FutureBuilder(
      future: futureServer,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<Server> servers = [];
          servers = snapshot.data;
          income = servers.elementAt(Provider.of<ServerProvider>(context).choosedIndex!).income;
          return Align(
            alignment: Alignment.center,
            child: ListView(
              children: [
                SizedBox(
                  height: 30,
                ),

                //INCOME INFORMATION
                Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "${income!.getIncome()}\n",
                        style: TextStyle(
                          fontFamily: "Open Sans",
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                        ),
                      ),
                      TextSpan(
                        text: "Your Income",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 50,
                ),

                //MONTH-YEAR
                Center(
                  child: Container(
                    width: 160,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Color(myColors.primarySoftGreen()).withOpacity(0.35),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.keyboard_arrow_left_rounded,
                            size: 20,
                          ),
                        ),
                        Text(
                          "June 2021",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Color(myColors.primarySoftGreen()).withOpacity(0.35),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.keyboard_arrow_right_rounded,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //INCOME CHART
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8 > 310 ? MediaQuery.of(context).size.width * 0.8 : 310,
                    height: 90,
                    child: chart(incomeDummys),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),

                //INCOME CARD-1
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8 > 310 ? MediaQuery.of(context).size.width * 0.8 : 310,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Widgets().incomeCard(
                          color: Color(myColors.secondaryBlue()),
                          icon: Icon(
                            Icons.receipt_rounded,
                            size: 28,
                            color: Color(myColors.secondaryTextColor()),
                          ),
                          title: "Total Bill",
                          amount: "Rp.${moneyFormat.format(income!.totalBill)}",
                        ),
                        Widgets().incomeCard(
                          color: Color(myColors.primaryBlue()),
                          icon: Icon(
                            Icons.receipt_long_rounded,
                            size: 28,
                            color: Color(myColors.secondaryTextColor()),
                          ),
                          title: "Total Tax",
                          amount: "Rp.${moneyFormat.format(income!.tax)}",
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),

                //INCOME CARD-2
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8 > 310 ? MediaQuery.of(context).size.width * 0.8 : 310,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Widgets().incomeCard(
                          color: Color(myColors.thirdSoftGreen()),
                          icon: Icon(
                            Icons.money_off_rounded,
                            size: 28,
                            color: Color(myColors.secondaryTextColor()),
                          ),
                          title: "Total Unpaid",
                          amount: "Rp.${moneyFormat.format(income!.unpaid)}",
                        ),
                        Widgets().incomeCard(
                          color: Color(myColors.primaryGreen()),
                          icon: Icon(
                            Icons.attach_money_rounded,
                            size: 28,
                            color: Color(myColors.secondaryTextColor()),
                          ),
                          title: "Total Paid",
                          amount: "Rp.${moneyFormat.format(income!.paid)}",
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),

                //INCOME CARD-3
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8 > 310 ? MediaQuery.of(context).size.width * 0.8 : 310,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Widgets().incomeCard(
                          color: Color(myColors.primaryYellow()),
                          icon: Icon(
                            Icons.attach_money_rounded,
                            size: 28,
                            color: Color(myColors.secondaryTextColor()),
                          ),
                          title: "Managed\nServices",
                          amount: "Rp.${moneyFormat.format(income!.managedServices)}",
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
