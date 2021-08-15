import 'package:flutter/material.dart';
import 'package:flutter_vinet/models/payment_model.dart';
import 'package:flutter_vinet/models/server_model.dart';
import 'package:flutter_vinet/modules/Sub%20Menu/payment/widgets/pdfToPrint.dart';
import 'package:flutter_vinet/provider/server_provider.dart';
import 'package:flutter_vinet/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

final moneyFormat = new NumberFormat("#,##0", "en_US");

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> with TickerProviderStateMixin {
  Future? futureServer;
  List<bool> showPayments = [];
  TextEditingController searchController = TextEditingController();
  List<Server> servers = [];
  Server choosedServer = Server();
  List<Payment> payments = [];
  List<Payment> searchPayment = [];
  ScrollController scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureServer = Provider.of<ServerProvider>(context, listen: false).getServerList();
    scrollController.addListener(onScroll);
  }

  Future fetchDataMore() async {
    await Future.delayed(Duration(seconds: 2));
    if (choosedServer.payments!.length - payments.length >= 10) {
      setState(() {
        payments.addAll(List.generate(10, (index) => choosedServer.payments!.elementAt(index + payments.length)));
        isLoading = false;
      });
    } else {
      setState(() {
        payments.addAll(
            List.generate(choosedServer.payments!.length - payments.length, (index) => choosedServer.payments!.elementAt(index + payments.length)));
        isLoading = false;
      });
    }
  }

  void showContainer(int index) {
    setState(() {
      showPayments[index] = !showPayments[index];
    });
  }

  void search(String value) {
    if (value.length != 0) {
      setState(() {
        searchPayment = choosedServer.payments!.where((payment) => payment.name!.toLowerCase().contains(value.toLowerCase())).toList();
      });
    } else {
      setState(() {
        searchPayment = payments;
      });
    }
  }

  onScroll() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent && !scrollController.position.outOfRange) {
      setState(() {
        isLoading = true;
      });
      fetchDataMore();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(myColors.secondaryWhiteScreen()),
      body: FutureBuilder(
        future: futureServer,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            servers = snapshot.data;
            choosedServer = servers.elementAt(Provider.of<ServerProvider>(context).choosedIndex!);
            if (searchController.text.length == 0 && payments.length == 0) {
              payments.addAll(
                List.generate(
                  choosedServer.payments!.length > 10 ? 10 : choosedServer.payments!.length,
                  (index) => choosedServer.payments!.elementAt(index),
                ),
              );
              searchPayment = payments;
            }
            for (var i = 0; i < payments.length; i++) {
              showPayments.add(false);
            }
            return CustomScrollView(
              controller: scrollController,
              slivers: <Widget>[
                _buildSliverAppBar(),
                _buildSliverList(),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      title: Text(
        "Payment",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      expandedHeight: 200.0,
      floating: true,
      pinned: true,
      snap: false,
      backgroundColor: Color(myColors.thirdGreen()),
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          var top = constraints.biggest.height;
          return FlexibleSpaceBar(
            centerTitle: true,
            title: top > 71 && top < 91
                ? Text("")
                : Widgets().searchBox(
                    thingToSearch: "Payment",
                    searchController: searchController,
                    search: (value) => search(value),
                  ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  child: Image.asset(
                    "assets/images/payment/payment.png",
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  color: Color(myColors.thirdGreen()).withOpacity(0.76),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        List.generate(
          searchController.text.length == 0 ? payments.length : searchPayment.length,
          (index) {
            int listLength;
            if (searchController.text.length == 0 ) {
              listLength = payments.length;
            } else {
              listLength = searchPayment.length;
            }
            Payment payment = searchController.text.length == 0 ? payments.elementAt(index) : searchPayment.elementAt(index);
            if (listLength == index) {
              return Center(
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),

                  //GREEN CONTAINER
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8 > 310 ? MediaQuery.of(context).size.width * 0.8 : 310,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: showPayments[index]
                          ? BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            )
                          : BorderRadius.circular(10),
                      color: Color(myColors.primaryGreen()),
                    ),
                    child: Stack(
                      children: [
                        //PAYMENT DATE
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.only(right: 30),
                            width: 80,
                            height: 13,
                            decoration: BoxDecoration(
                              color: Color(myColors.secondarySoftGreen()),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ),
                            ),
                            child: Text(
                              payment.paymentDate.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Roboto Condensed",
                                fontWeight: FontWeight.w700,
                                fontSize: 9,
                              ),
                            ),
                          ),
                        ),

                        //PAYMENT NAME
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Text(
                                "     From : ${payment.name}",
                                style: TextStyle(
                                  fontFamily: "Nunito Sans",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            //CLICK TO SHOW CONTAINER
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
                        )
                      ],
                    ),
                  ),

                  //CONTAINER TO SHOW AFTER CLICK
                  AnimatedSize(
                    vsync: this,
                    duration: Duration(milliseconds: 600),
                    child: showPayments[index]
                        ? Container(
                            padding: EdgeInsets.only(bottom: 7),
                            width: MediaQuery.of(context).size.width * 0.8 > 310 ? MediaQuery.of(context).size.width * 0.8 : 310,
                            height: 300,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
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
                                //COMPANY LOGO
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      "assets/images/payment/vinet.png",
                                    ),
                                    Image.asset(
                                      "assets/images/payment/rtiga.png",
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    //USER INFORMATION
                                    Container(
                                      padding: EdgeInsets.only(left: 20),
                                      width: 200,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 43,
                                                child: Text(
                                                  "From",
                                                  style: TextStyle(
                                                    fontSize: 9,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  payment.name.toString(),
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontFamily: "Nunito Sans",
                                                    fontSize: 9,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 43,
                                                child: Text(
                                                  "Address",
                                                  style: TextStyle(
                                                    fontSize: 9,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  payment.address.toString(),
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontFamily: "Nunito Sans",
                                                    fontSize: 9,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 43,
                                                child: Text(
                                                  "Phone",
                                                  style: TextStyle(
                                                    fontSize: 9,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  payment.phone.toString(),
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontFamily: "Nunito Sans",
                                                    fontSize: 9,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),

                                    //PAID IMAGE
                                    Image.asset("assets/images/payment/paid.png"),
                                  ],
                                ),

                                //ROW 3-INFORMATIONS ABOUT PACKETS SPECIFICATION
                                Container(
                                  width: 200,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      //PACKET TYPE
                                      Container(
                                        width: 52,
                                        height: 52,
                                        decoration: BoxDecoration(
                                          color: Color(myColors.secondaryGreen()).withOpacity(0.74),
                                          borderRadius: BorderRadius.circular(15),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              offset: Offset(0, 2),
                                              blurRadius: 4,
                                              spreadRadius: 0,
                                              color: Color(myColors.primaryGreen()).withOpacity(0.25),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 7,
                                            ),
                                            Icon(
                                              Icons.shopping_bag_rounded,
                                              color: Color(myColors.darkBlue()),
                                              size: 28,
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              payment.packetType.toString(),
                                              style: TextStyle(
                                                fontFamily: "Nunito Sans",
                                                fontSize: 7,
                                                color: Color(myColors.darkBlue()),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      //PACKET SPEED
                                      Container(
                                        width: 52,
                                        height: 52,
                                        decoration: BoxDecoration(
                                          color: Color(myColors.secondaryGreen()).withOpacity(0.74),
                                          borderRadius: BorderRadius.circular(15),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              offset: Offset(0, 2),
                                              blurRadius: 4,
                                              spreadRadius: 0,
                                              color: Color(myColors.primaryGreen()).withOpacity(0.25),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 7,
                                            ),
                                            Icon(
                                              Icons.network_check_rounded,
                                              color: Color(myColors.darkBlue()),
                                              size: 28,
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              "${payment.packetSpeed} Mbps",
                                              style: TextStyle(
                                                fontFamily: "Nunito Sans",
                                                fontSize: 7,
                                                color: Color(myColors.darkBlue()),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      //PACKET PRICE
                                      Container(
                                        width: 52,
                                        height: 52,
                                        decoration: BoxDecoration(
                                          color: Color(myColors.secondaryGreen()).withOpacity(0.74),
                                          borderRadius: BorderRadius.circular(15),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              offset: Offset(0, 2),
                                              blurRadius: 4,
                                              spreadRadius: 0,
                                              color: Color(myColors.primaryGreen()).withOpacity(0.25),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 7,
                                            ),
                                            Icon(
                                              Icons.paid_rounded,
                                              color: Color(myColors.darkBlue()),
                                              size: 28,
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              "Rp.${moneyFormat.format(payment.packetPrice)}",
                                              style: TextStyle(
                                                fontFamily: "Nunito Sans",
                                                fontSize: 7,
                                                color: Color(myColors.darkBlue()),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        //RECEIVED BY
                                        Container(
                                          child: Row(
                                            children: [
                                              Text(
                                                "2 hours ago",
                                                style: TextStyle(
                                                  fontFamily: "Nunito Sans",
                                                  fontSize: 8,
                                                  color: Colors.black.withOpacity(0.5),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Container(
                                                height: 4,
                                                width: 4,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.black.withOpacity(0.5),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text(
                                                "Received by Rafika Amalia",
                                                style: TextStyle(
                                                  fontFamily: "Nunito Sans",
                                                  fontSize: 8,
                                                  color: Colors.black.withOpacity(0.5),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        //PRINT BUTTON
                                        Container(
                                          width: 70,
                                          height: 25,
                                          decoration: BoxDecoration(
                                            color: Color(myColors.primaryBlue()),
                                            borderRadius: BorderRadius.circular(5),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                offset: Offset(0, 2),
                                                blurRadius: 4,
                                                spreadRadius: 0,
                                                color: Color(myColors.primaryBlue()).withOpacity(0.3),
                                              ),
                                            ],
                                          ),
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            onPressed: () => printPdf(payment),
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(Color(myColors.primaryBlue())),
                                              alignment: Alignment.center,
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.print_rounded,
                                                  size: 16,
                                                  color: Color(myColors.secondaryTextColor()),
                                                ),
                                                Text(
                                                  "Print",
                                                  style: TextStyle(
                                                    fontFamily: "Nunito Sans",
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 9,
                                                    color: Color(myColors.secondaryTextColor()),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
