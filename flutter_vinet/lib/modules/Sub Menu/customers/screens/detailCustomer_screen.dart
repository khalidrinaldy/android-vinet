import 'package:flutter/material.dart';
import 'package:flutter_vinet/models/customer_model.dart';
import 'package:flutter_vinet/widgets/widgets.dart';

class DetailCustomer extends StatelessWidget {
  final Customer customer;
  const DetailCustomer({Key? key, required this.customer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Color(myColors.primaryGreen()),
        title: Text(
          customer.name.toString(),
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, left: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.account_circle_rounded,
                    size: 65,
                    color: Color(myColors.primaryGreen()),
                  ),
                  SizedBox(
                    width: 17,
                  ),
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: "${customer.name}\n",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            )),
                        TextSpan(
                          text: customer.id,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20,top: 9),
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 125,
                  decoration: BoxDecoration(
                    color: Color(myColors.darkGreen2()),
                    border: Border.symmetric(
                      vertical: BorderSide(
                        color: Color(myColors.primaryGreen()),
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 9,
                      ),
                      Container(
                        height: 17,
                        child: Row(
                          children: [
                            Container(
                              width: 77,
                              child: Text(
                                "IP",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              customer.ipNumber.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 17,
                        child: Row(
                          children: [
                            Container(
                              width: 77,
                              child: Text(
                                "Status",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              customer.isConnected! ? "Connected" : "Disconnected",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 17,
                        child: Row(
                          children: [
                            Container(
                              width: 77,
                              child: Text(
                                "Paket",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              "${customer.packetSpeed} Mbps",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 17,
                        child: Row(
                          children: [
                            Container(
                              width: 77,
                              child: Text(
                                "Upload",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              customer.upload.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 17,
                        child: Row(
                          children: [
                            Container(
                              width: 77,
                              child: Text(
                                "Download",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              customer.download.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 13, left: 20),
                  width: 85,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color(myColors.primaryGreen()),
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Connection",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
