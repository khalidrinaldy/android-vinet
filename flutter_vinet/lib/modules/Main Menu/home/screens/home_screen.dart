import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_vinet/models/server_model.dart';
import 'package:flutter_vinet/modules/Main%20Menu/home/widgets/chart.dart';
import 'package:flutter_vinet/provider/server_provider.dart';
import 'package:flutter_vinet/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Server>? servers;
  Server? choosedServer;
  Stream? streamServer;
  List<ConnectData> stats = [];
  final random = Random();
  List<Map<String, dynamic>> dummyStats = [
    {"speed": "5 Mbps", "current": 41, "total": 400},
    {"speed": "7 Mbps", "current": 10, "total": 400},
    {"speed": "8 Mbps", "current": 5, "total": 400},
    {"speed": "10 Mbps", "current": 280, "total": 400},
    {"speed": "15 Mbps", "current": 76, "total": 400},
    {"speed": "20 Mbps", "current": 5, "total": 400},
    {"speed": "Others", "current": 19, "total": 400},
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if (stats.length == 5) {
        stats.removeAt(0);
      }
      stats.add(ConnectData(random.nextDouble() * (200 - 50) + 50, random.nextDouble() * (600 - 100) + 100));
    });
    streamServer = Provider.of<ServerProvider>(context, listen: false).streamServers(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(myColors.secondaryWhiteScreen()),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          shrinkWrap: true,
          children: [
            Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        "assets/images/dashboard/ellipse.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
                StreamBuilder(
                  stream: streamServer,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      servers = snapshot.data;
                      choosedServer = servers!.elementAt(Provider.of<ServerProvider>(context).choosedIndex!);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTitleHello(),
                          _buildInformationCard(context, choosedServer!),
                          _buildRowSubMenu(context),
                          _buildChart(choosedServer!),
                          _buildStatsServer(choosedServer!),
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleHello() {
    return Container(
        margin: EdgeInsets.only(top: 50, left: 24),
        child: RichText(
          text: TextSpan(children: <TextSpan>[
            TextSpan(
              text: "Hello,\n",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: "VN123456",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 28,
                color: Colors.black,
              ),
            ),
          ]),
        ));
  }

  Widget _buildInformationCard(BuildContext context, Server server) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.only(top: 16),
        height: 200,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 4,
              spreadRadius: 0,
              color: Colors.black.withOpacity(0.25),
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 7, left: 7),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: server.isOnline! ? Color(myColors.primaryGreen()) : Color(myColors.primaryRed()),
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      height: 25,
                      width: 25,
                      child: Image.asset(
                        "assets/images/dashboard/server.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        server.name.toString(),
                        style: TextStyle(
                          fontFamily: "Nunito Sans",
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        server.ipNumber.toString(),
                        style: TextStyle(
                          fontFamily: "Nunito Sans",
                          fontSize: 10,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(bottom: 5),
                height: 10,
                width: 80,
                decoration: BoxDecoration(
                  color: Color(myColors.primaryGreen()),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(2),
                    bottomLeft: Radius.circular(2),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  server.isOnline! ? "Online" : "Offline",
                  style: TextStyle(
                    fontFamily: "Nunito Sans",
                    fontWeight: FontWeight.w700,
                    fontSize: 8,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Total Customers",
                            style: TextStyle(
                              fontFamily: "Nunito Sans",
                              fontSize: 10,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                          Text(
                            server.customers!.length.toString(),
                            style: TextStyle(
                              fontFamily: "Nunito Sans",
                              fontSize: 13,
                              color: Color(myColors.secondaryTextColor()).withOpacity(0.7),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Total Queue",
                            style: TextStyle(
                              fontFamily: "Nunito Sans",
                              fontSize: 10,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                          Text(
                            server.queue!.length.toString(),
                            style: TextStyle(
                              fontFamily: "Nunito Sans",
                              fontSize: 13,
                              color: Color(myColors.secondaryTextColor()).withOpacity(0.7),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Total Income",
                            style: TextStyle(
                              fontFamily: "Nunito Sans",
                              fontSize: 10,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                          Text(
                            server.income!.getIncome().toString(),
                            style: TextStyle(
                              fontFamily: "Nunito Sans",
                              fontSize: 13,
                              color: Color(myColors.secondaryTextColor()).withOpacity(0.7),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Server Load",
                            style: TextStyle(
                              fontFamily: "Nunito Sans",
                              fontSize: 10,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                          Container(
                            width: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircularPercentIndicator(
                                  radius: 30,
                                  lineWidth: 4,
                                  animation: true,
                                  percent: server.cpuLoad! / 100,
                                  center: Text(
                                    "${server.cpuLoad}%",
                                    style: TextStyle(
                                      fontFamily: "Nunito Sans",
                                      fontSize: 8,
                                    ),
                                  ),
                                  footer: Text(
                                    "CPU",
                                    style: TextStyle(
                                      fontFamily: "Nunito Sans",
                                      fontSize: 8,
                                    ),
                                  ),
                                  progressColor: Color(myColors.darkGreen()),
                                  backgroundColor: Color(myColors.secondaryGrey()).withOpacity(0.5),
                                ),
                                CircularPercentIndicator(
                                  radius: 30,
                                  lineWidth: 4,
                                  animation: true,
                                  percent: server.ramLoad! / 100,
                                  center: Text(
                                    "${server.ramLoad}%",
                                    style: TextStyle(
                                      fontFamily: "Nunito Sans",
                                      fontSize: 8,
                                    ),
                                  ),
                                  footer: Text(
                                    "RAM",
                                    style: TextStyle(
                                      fontFamily: "Nunito Sans",
                                      fontSize: 8,
                                    ),
                                  ),
                                  progressColor: Color(myColors.darkGreen()),
                                  backgroundColor: Color(myColors.secondaryGrey()).withOpacity(0.5),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRowSubMenu(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.only(top: 20),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/customers'),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(myColors.primarySoftGreen()).withOpacity(0.25),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.groups_rounded,
                      size: 28,
                      color: Color(myColors.primaryGreen()),
                    ),
                  ),
                ),
                Text(
                  "Customers",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Rubik",
                    fontSize: 8,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/payments');
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(myColors.primarySoftGreen()).withOpacity(0.25),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.payment_rounded,
                      size: 28,
                      color: Color(myColors.primaryGreen()),
                    ),
                  ),
                ),
                Text(
                  "Payment",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Rubik",
                    fontSize: 8,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/queue'),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(myColors.primarySoftGreen()).withOpacity(0.25),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.reduce_capacity_rounded,
                      size: 28,
                      color: Color(myColors.primaryGreen()),
                    ),
                  ),
                ),
                Text(
                  "Queue",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Rubik",
                    fontSize: 8,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/income'),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(myColors.primarySoftGreen()).withOpacity(0.25),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.paid_rounded,
                      size: 28,
                      color: Color(myColors.primaryGreen()),
                    ),
                  ),
                ),
                Text(
                  "Income",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Rubik",
                    fontSize: 8,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/area'),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(myColors.primarySoftGreen()).withOpacity(0.25),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.location_city_rounded,
                      size: 28,
                      color: Color(myColors.primaryGreen()),
                    ),
                  ),
                ),
                Text(
                  "Area",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Rubik",
                    fontSize: 8,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChart(Server server) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 24, top: 50, bottom: 10),
            child: Text(
              "Traffic Router ${server.name}",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
          Container(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 95,
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 5,
                        color: Color(myColors.primaryBlue()),
                      ),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: "  TX ",
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Color(myColors.secondaryTextColor()),
                                )),
                            TextSpan(
                              text: "${stats.elementAt(stats.length - 1).tx.toStringAsFixed(2)}  Mbps",
                              style: TextStyle(
                                fontSize: 8,
                                color: Color(myColors.secondaryTextColor()),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 95,
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 5,
                            color: Color(myColors.primaryGreen()),
                          ),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: "  RX ",
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: Color(myColors.secondaryTextColor()),
                                    )),
                                TextSpan(
                                  text: "${stats.elementAt(stats.length - 1).rx.toStringAsFixed(2)}  Mbps",
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Color(myColors.secondaryTextColor()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 100,
            child: chart(stats),
          )
        ],
      ),
    );
  }

  Widget _buildStatsServer(Server server) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.all(6),
        width: 320,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 4,
              spreadRadius: -1,
              color: Colors.black.withOpacity(0.25),
            ),
          ],
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Text(
              server.name.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Nunito Sans",
                fontSize: 14,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(top: 30),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      offset: Offset(0, 1),
                      blurRadius: 4,
                      spreadRadius: 0,
                      color: Colors.black.withOpacity(0.25),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      server.customers!.length.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Nunito Sans",
                        fontSize: 24,
                        color: Color(myColors.secondaryTextColor()),
                      ),
                    ),
                    Text(
                      "Total Customers",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Nunito Sans",
                        fontSize: 12,
                        color: Color(myColors.secondaryTextColor()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        offset: Offset(0, 1),
                        blurRadius: 4,
                        spreadRadius: 0,
                        color: Colors.black.withOpacity(0.25),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        server.clientsLoad.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Nunito Sans",
                          fontSize: 24,
                          color: Color(myColors.primaryBlue()),
                        ),
                      ),
                      Text(
                        "Client Over Load",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Nunito Sans",
                          fontSize: 12,
                          color: Color(myColors.secondaryTextColor()),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        offset: Offset(0, 1),
                        blurRadius: 4,
                        spreadRadius: 0,
                        color: Colors.black.withOpacity(0.25),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${server.profitSinceLastTarget}%",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Nunito Sans",
                          fontSize: 24,
                          color: Color(myColors.secondaryGreen()),
                        ),
                      ),
                      Text(
                        "Since Last Target",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Nunito Sans",
                          fontSize: 12,
                          color: Color(myColors.secondaryTextColor()),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Customers",
                style: TextStyle(
                  fontFamily: "Nunito Sans",
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Color(myColors.secondaryTextColor()),
                ),
              ),
            ),
            Container(
              height: 200,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: dummyStats.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(top: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dummyStats[index]["speed"],
                        style: TextStyle(
                          fontFamily: "Nunito Sans",
                          fontSize: 11,
                        ),
                      ),
                      Stack(
                        children: [
                          LinearPercentIndicator(
                            width: 230,
                            lineHeight: 15,
                            percent: dummyStats[index]["current"] / dummyStats[index]["total"],
                            progressColor: Color(myColors.primaryGreen()),
                            backgroundColor: Color(0xFFC4C4C4).withOpacity(0.2),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            width: 230,
                            alignment: Alignment.centerRight,
                            child: Text("${dummyStats[index]["current"]}/${dummyStats[index]["total"]}",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontFamily: "Nunito Sans",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 9,
                                  color: Color(myColors.secondaryTextColor()),
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
