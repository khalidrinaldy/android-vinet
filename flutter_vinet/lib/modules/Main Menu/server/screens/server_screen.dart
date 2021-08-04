import 'package:flutter/material.dart';
import 'package:flutter_vinet/provider/server_provider.dart';
import 'package:flutter_vinet/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ServerScreen extends StatefulWidget {
  const ServerScreen({Key? key}) : super(key: key);

  @override
  _ServerScreenState createState() => _ServerScreenState();
}

class _ServerScreenState extends State<ServerScreen> with TickerProviderStateMixin {
  List<bool>? showServers = [];

  void showContainer(int index) {
    setState(() {
      showServers![index] = !showServers![index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ServerProvider(),
      child: Consumer<ServerProvider>(
        builder: (context, serverProvider, _) {
          for (var i = 0; i < serverProvider.servers!.length; i++) {
            showServers!.add(false);
          }
          return Scaffold(
            backgroundColor: Color(myColors.secondaryWhiteScreen()),
            body: Container(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40, left: 30, bottom: 35),
                    child: Text(
                      "Server List",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  _buildServerList(serverProvider),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildServerList(ServerProvider serverProvider) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: serverProvider.servers!.length,
      itemBuilder: (context, index) {
        var paid = 0;
        var unpaid = 0;
        serverProvider.servers!.elementAt(index).customers!.forEach((e) {
          if (e.isPaid!) {
            paid += 1;
          } else {
            unpaid += 1;
          }
        });
        var noData = serverProvider.servers!.elementAt(index).customers!.length - (paid + unpaid);
        return Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(top: 15),
                width: MediaQuery.of(context).size.width * 0.8 > 300 ? MediaQuery.of(context).size.width * 0.8 : 300,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color(myColors.primaryGreen()),
                    width: 1,
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 4,
                      spreadRadius: -1,
                      color: Colors.black.withOpacity(0.25),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Color(myColors.primaryGreen()),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 4,
                            spreadRadius: -1,
                            color: Colors.black.withOpacity(0.25),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "assets/images/server/server.png",
                      ),
                    ),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  "   ${serverProvider.servers!.elementAt(index).name.toString()} ${index == serverProvider.choosedIndex ? "(choosed)" : ""}\n",
                              style: TextStyle(
                                fontFamily: "Nunito Sans",
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: "   ${serverProvider.servers!.elementAt(index).ipNumber.toString()}\n",
                              style: TextStyle(
                                fontFamily: "Nunito Sans",
                                fontSize: 14,
                                color: Color(myColors.secondaryTextColor()),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 30,
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () => showContainer(index),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 26,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: AnimatedSize(
                vsync: this,
                duration: Duration(milliseconds: 600),
                child: showServers![index]
                    ? Container(
                        padding: EdgeInsets.fromLTRB(8, 30, 8, 15),
                        key: UniqueKey(),
                        width: 280,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 4,
                              spreadRadius: 0,
                              color: Colors.black.withOpacity(0.25),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text.rich(
                                TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "${paid + unpaid + noData}\n",
                                      style: TextStyle(
                                        fontFamily: "Nunito Sans",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Total Users",
                                      style: TextStyle(
                                        fontFamily: "Nunito Sans",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 80,
                                  child: Text.rich(
                                    TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "$paid\n",
                                          style: TextStyle(
                                            fontFamily: "Nunito Sans",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            color: Color(myColors.secondaryGreen()),
                                          ),
                                        ),
                                        TextSpan(
                                          text: "Users Paid",
                                          style: TextStyle(
                                            fontFamily: "Nunito Sans",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  child: Text.rich(
                                    TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "$unpaid\n",
                                          style: TextStyle(
                                            fontFamily: "Nunito Sans",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            color: Color(myColors.primaryRed()),
                                          ),
                                        ),
                                        TextSpan(
                                          text: "Users Unpaid",
                                          style: TextStyle(
                                            fontFamily: "Nunito Sans",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  child: Text.rich(
                                    TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "$noData\n",
                                          style: TextStyle(
                                            fontFamily: "Nunito Sans",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            color: Color(myColors.primaryBlue()),
                                          ),
                                        ),
                                        TextSpan(
                                          text: "No Data",
                                          style: TextStyle(
                                            fontFamily: "Nunito Sans",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              width: 70,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(myColors.primaryGreen()),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    offset: Offset(0, 2),
                                    blurRadius: 4,
                                    spreadRadius: 0,
                                    color: Colors.black.withOpacity(0.25),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Color(myColors.primaryGreen())),
                                ),
                                child: Text(
                                  "Use",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Nunito Sans",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(),
              ),
            )
          ],
        );
      },
    );
  }
}
