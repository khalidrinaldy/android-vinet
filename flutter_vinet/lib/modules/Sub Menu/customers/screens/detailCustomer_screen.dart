import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vinet/models/customer_model.dart';
import 'package:flutter_vinet/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailCustomer extends StatelessWidget {
  final Customer customer;
  const DetailCustomer({Key? key, required this.customer}) : super(key: key);

  openwhatsapp(BuildContext context) async {
    var phone = "085839951911";
    var text = "Hello There";
    var url = "https://wa.me/$phone?text=$text";
    var encodedUrl = Uri.encodeFull(url);
    if (await canLaunch(encodedUrl)) {
      await launch(encodedUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
    }
  }

  sharewhatsapp(BuildContext context, Customer customer) async {
    var text = "Hello There\n\nName\t\t:${customer.name}\nPhone\t\t:${customer.phone}\nAddress\t\t:${customer.address}";
    var url = "https://wa.me/?text=$text";
    var encodedUrl = Uri.encodeFull(url);
    if (await canLaunch(encodedUrl)) {
      await launch(encodedUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
    }
  }

  openlocation(BuildContext context, Customer customer) async {
    var text = customer.address.toString();
    var url = "https://www.google.com/maps/search/$text";
    var encodedUrl = Uri.encodeFull(url);
    if (await canLaunch(encodedUrl)) {
      await launch(encodedUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text("google maps no installed")));
    }
  }

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
            _buildCustomerProfile(),
            _buildConnectionInfo(context),
            _buildPaymentInfo(context),
            _buildInformation(context),
            _buildDangerArea(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerProfile() {
    return Container(
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
    );
  }

  Widget _buildConnectionInfo(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, top: 9),
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
    );
  }

  Widget _buildPaymentInfo(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, top: 9),
          margin: EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width,
          height: 85,
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
                        "Status",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      customer.isPaid! ? "Paid" : "Unpaid",
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
                        "Action",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Widgets().smallButton(
                      color: Color(myColors.primaryGreen()),
                      icon: Icon(
                        Icons.check_circle_rounded,
                        size: 12,
                        color: Colors.white,
                      ),
                      text: "Paid",
                      onPressed: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.WARNING,
                          animType: AnimType.BOTTOMSLIDE,
                          title: "WARNING USER PAYMENT",
                          desc: "Apakah benar user telah membayar ? ",
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.SUCCES,
                              animType: AnimType.SCALE,
                              title: "SUCCESS",
                              desc: "PAID SUCCESS",
                              btnOkOnPress: () {},
                            )..show();
                          },
                        )..show();
                      },
                    ),
                  ],
                ),
              ),
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
            "Payment",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInformation(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, top: 9),
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
                        "Type",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      customer.type.toString(),
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
                        "Join Date",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      customer.joinDate.toString(),
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
                        "Address",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        customer.address.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: Colors.white,
                        ),
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
                        "Action",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Widgets().smallButton(
                            color: Color(myColors.primaryGreen()),
                            icon: Image.asset("assets/images/queue/mdi_whatsapp.png"),
                            text: "WhatsApp",
                            onPressed: () => openwhatsapp(context),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Widgets().smallButton(
                            color: Color(myColors.primaryOrange()),
                            icon: Icon(
                              Icons.location_on_rounded,
                              size: 12,
                              color: Colors.white,
                            ),
                            text: "Shareloc",
                            onPressed: () {
                              openlocation(context, customer);
                            },
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Widgets().smallButton(
                            color: Color(myColors.primaryBlue()),
                            icon: Icon(
                              Icons.send_rounded,
                              size: 12,
                              color: Colors.white,
                            ),
                            text: "Share",
                            onPressed: () {
                              sharewhatsapp(context, customer);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
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
            "Information",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDangerArea(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, top: 9),
          margin: EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width,
          height: 85,
          decoration: BoxDecoration(
            color: Color(myColors.darkGreen2()),
            border: Border.symmetric(
              vertical: BorderSide(
                color: Color(myColors.darkRed()),
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
                        "Delete",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Widgets().smallButton(
                      color: Color(myColors.primaryRed()),
                      icon: Icon(
                        Icons.delete_rounded,
                        size: 12,
                        color: Colors.white,
                      ),
                      text: "Delete",
                      onPressed: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.WARNING,
                          animType: AnimType.BOTTOMSLIDE,
                          title: "WARNING USER DELETE",
                          desc: "Are you sure want to delete ? ",
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.SUCCES,
                              animType: AnimType.SCALE,
                              title: "SUCCESS",
                              desc: "DELETE SUCCESS",
                              btnOkOnPress: () {
                                Navigator.pop(context);
                              },
                            )..show();
                          },
                        )..show();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 17,
                child: Row(
                  children: [
                    Container(
                      width: 77,
                      child: Text(
                        "Enable/Disable",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Widgets().smallButton(
                          color: Color(myColors.primaryGreen()),
                          icon: Icon(
                            Icons.check_circle_rounded,
                            size: 12,
                            color: Colors.white,
                          ),
                          text: "Enable",
                          onPressed: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.SUCCES,
                              animType: AnimType.SCALE,
                              title: "SUCCESS",
                              desc: "ENABLE CONNECTION SUCCESS",
                              btnOkOnPress: () {},
                            )..show();
                          },
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Widgets().smallButton(
                          color: Color(myColors.darkRed()),
                          icon: Icon(
                            Icons.cancel_rounded,
                            size: 12,
                            color: Colors.white,
                          ),
                          text: "Disable",
                          onPressed: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.SUCCES,
                              animType: AnimType.SCALE,
                              title: "SUCCESS",
                              desc: "DISABLE CONNECTION SUCCESS",
                              btnOkOnPress: () {},
                            )..show();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
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
              color: Color(myColors.darkRed()),
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            "Danger Area",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
