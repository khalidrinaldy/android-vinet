import 'package:flutter/material.dart';
import 'package:flutter_vinet/models/queue_model.dart';
import 'package:flutter_vinet/models/server_model.dart';
import 'package:flutter_vinet/provider/server_provider.dart';
import 'package:flutter_vinet/widgets/widgets.dart';
import 'package:provider/provider.dart';

class QueueScreen extends StatefulWidget {
  const QueueScreen({Key? key}) : super(key: key);

  @override
  _QueueScreenState createState() => _QueueScreenState();
}

class _QueueScreenState extends State<QueueScreen> {
  Future? futureServer;
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  List<Server> servers = [];
  Server choosedServer = Server();
  List<Queue> queue = [];
  List<Queue> searchQueue = [];
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
        searchQueue = choosedServer.queue!.where((q) => q.sender!.toLowerCase().contains(value.toLowerCase())).toList();
      });
    } else {
      setState(() {
        searchQueue = queue;
      });
    }
  }

  Future fetchDataMore() async {
    await Future.delayed(Duration(seconds: 2));
    if (choosedServer.queue!.length - queue.length >= 10) {
      setState(() {
        queue.addAll(List.generate(10, (index) => choosedServer.queue!.elementAt(index + queue.length)));
        isLoading = false;
      });
    } else {
      setState(() {
        queue.addAll(List.generate(choosedServer.queue!.length - queue.length, (index) => choosedServer.queue!.elementAt(index + queue.length)));
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
            if (searchController.text.length == 0 && queue.length == 0) {
              queue.addAll(
                List.generate(
                  choosedServer.queue!.length > 10 ? 10 : choosedServer.queue!.length,
                  (index) => choosedServer.queue!.elementAt(index),
                ),
              );
              searchQueue = queue;
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
        "Queue",
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
                    thingToSearch: "Queue",
                    searchController: searchController,
                    search: (value) => search(value),
                  ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  child: Image.asset(
                    "assets/images/queue/queue.png",
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
          searchController.text.length == 0 ? queue.length : searchQueue.length,
          (index) {
            int listLength;
            if (searchController.text.length == 0 ) {
              listLength = queue.length;
            } else {
              listLength = searchQueue.length;
            }
            Queue q = searchController.text.length == 0 ? queue.elementAt(index) : searchQueue.elementAt(index);
            if (listLength == index) {
              return Center(
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                  width: MediaQuery.of(context).size.width * 0.8 > 310 ? MediaQuery.of(context).size.width * 0.8 : 310,
                  height: 215,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 4,
                        spreadRadius: -1,
                        color: Colors.black.withOpacity(0.25),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          //VINET CIRCLE LOGO
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(
                                image: AssetImage("assets/images/queue/vinet.png"),
                              ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 4,
                                  spreadRadius: -1,
                                  color: Colors.black.withOpacity(0.25),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),

                          //SENDER NAME & SENDER DATE
                          Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: "${q.sender}\n",
                                  style: TextStyle(
                                    fontFamily: "Nunito Sans",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                                TextSpan(
                                  text: "On ${q.date}",
                                  style: TextStyle(
                                    fontFamily: "Nunito Sans",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      //PACKET INFORMATION
                      Column(
                        children: [
                          //PACKET TYPE
                          Row(
                            children: [
                              Container(
                                width: 23,
                                height: 23,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(myColors.darkGreen()),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Icon(
                                  Icons.shopping_bag_rounded,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                "Paket ${q.packetType}",
                                style: TextStyle(
                                  fontFamily: "Nunito Sans",
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),

                          //SENDER AREA
                          Row(
                            children: [
                              Container(
                                width: 23,
                                height: 23,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(myColors.darkGreen()),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Icon(
                                  Icons.location_on_rounded,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                "${q.area}",
                                style: TextStyle(
                                  fontFamily: "Nunito Sans",
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),

                          //SENDER ADDRESS
                          Row(
                            children: [
                              Container(
                                width: 23,
                                height: 23,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(myColors.darkGreen()),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Icon(
                                  Icons.home_filled,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              SizedBox(
                                width: 250,
                                child: Text(
                                  "${q.address}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: "Nunito Sans",
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //REGISTER BUTTON
                          Container(
                            width: 90,
                            height: 27,
                            decoration: BoxDecoration(
                              color: Color(myColors.secondaryGreen()),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                  color: Color(myColors.secondaryGreen()).withOpacity(0.25),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(myColors.primaryGreen()))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.person_add, color: Colors.white, size: 14),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Register",
                                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //SHARE BUTTON
                          Container(
                            width: 80,
                            height: 27,
                            decoration: BoxDecoration(
                              color: Color(myColors.secondaryGreen()),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                  color: Color(myColors.primaryBlue()).withOpacity(0.25),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(myColors.primaryBlue()))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.send, color: Colors.white, size: 14),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Share",
                                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //WHATSAPP BUTTON
                          Container(
                            width: 100,
                            height: 27,
                            decoration: BoxDecoration(
                              color: Color(myColors.primaryGreen()),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                  color: Color(myColors.primaryGreen()).withOpacity(0.25),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(myColors.primaryGreen()))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/queue/mdi_whatsapp.png"),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "WhatsApp",
                                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10),
                                  ),
                                ],
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
          },
        ),
      ),
    );
  }
}
