import 'package:flutter/material.dart';
import 'package:flutter_vinet/models/customer_model.dart';
import 'package:flutter_vinet/models/server_model.dart';
import 'package:flutter_vinet/provider/server_provider.dart';
import 'package:flutter_vinet/widgets/widgets.dart';
import 'package:provider/provider.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  Future? futureServer;
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  List<Server> servers = [];
  Server choosedServer = Server();
  List<Customer> customers = [];
  List<Customer> searchCustomer = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureServer = Provider.of<ServerProvider>(context, listen: false).getServerList();
    scrollController.addListener(onScroll);
  }

  void search(String value) {
    if (value.length != 0) {
      setState(() {
        searchCustomer = choosedServer.customers!.where((q) => q.name!.toLowerCase().contains(value.toLowerCase())).toList();
      });
    } else {
      setState(() {
        searchCustomer = customers;
      });
    }
  }

  Future fetchDataMore() async {
    await Future.delayed(Duration(seconds: 2));
    if (choosedServer.customers!.length - customers.length >= 10) {
      setState(() {
        customers.addAll(List.generate(10, (index) => choosedServer.customers!.elementAt(index + customers.length)));
        isLoading = false;
      });
    } else {
      setState(() {
        customers.addAll(List.generate(
            choosedServer.customers!.length - customers.length, (index) => choosedServer.customers!.elementAt(index + customers.length)));
        isLoading = false;
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
            if (searchController.text.length == 0 && customers.length == 0) {
              customers.addAll(List.generate(
                choosedServer.customers!.length > 10 ? 10 : choosedServer.customers!.length,
                (index) => choosedServer.customers!.elementAt(index),
              ));
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
        "Customers",
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
                    thingToSearch: "Customer",
                    searchController: searchController,
                    search: (value) => search(value),
                  ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  child: Image.asset(
                    "assets/images/customers/customers.png",
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
          searchController.text.length == 0 ? customers.length : searchCustomer.length,
          (index) {
            int listLength;
            if (searchController.text.length == 0) {
              listLength = customers.length;
            } else {
              listLength = searchCustomer.length;
            }
            Customer customer = searchController.text.length == 0 ? customers.elementAt(index) : searchCustomer.elementAt(index);
            if (listLength == index) {
              return Center(
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/detail-customer', arguments: customer),
                    child: Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 200,
                            child: Row(
                              children: [
                                Icon(Icons.account_circle_rounded, color: Color(myColors.primaryGreen()), size: 30,),
                                SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    customer.name.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: "Nunito Sans",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 60,
                                  height: 14,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: customer.isPaid! ? Color(myColors.primaryGreen()) : Color(myColors.primaryRed()),
                                  ),
                                  child: Text(
                                    customer.isPaid! ? "Paid" : "Unpaid",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "Nunito Sans",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 9,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Icon(Icons.keyboard_arrow_right_rounded, size: 24, ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Color(myColors.primaryGrey()).withOpacity(0.5),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
