import 'package:flutter/material.dart';
import 'package:flutter_vinet/models/area_model.dart';
import 'package:flutter_vinet/models/server_model.dart';
import 'package:flutter_vinet/provider/server_provider.dart';
import 'package:flutter_vinet/widgets/widgets.dart';
import 'package:provider/provider.dart';

class AreaScreen extends StatefulWidget {
  const AreaScreen({Key? key}) : super(key: key);

  @override
  _AreaScreenState createState() => _AreaScreenState();
}

class _AreaScreenState extends State<AreaScreen> {
  Future? futureServer;
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  List<Server> servers = [];
  Server choosedServer = Server();
  List<Area> areas = [];
  List<Area> searchArea = [];
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
        searchArea = choosedServer.areas!.where((q) => q.name!.toLowerCase().contains(value.toLowerCase())).toList();
      });
    } else {
      setState(() {
        searchArea = areas;
      });
    }
  }

  Future fetchDataMore() async {
    await Future.delayed(Duration(seconds: 2));
    if (choosedServer.areas!.length - areas.length >= 10) {
      setState(() {
        areas.addAll(List.generate(10, (index) => choosedServer.areas!.elementAt(index + areas.length)));
        isLoading = false;
      });
    } else {
      setState(() {
        areas.addAll(List.generate(choosedServer.areas!.length - areas.length, (index) => choosedServer.areas!.elementAt(index + areas.length)));
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
            if (searchController.text.length == 0 && areas.length == 0) {
              areas.addAll(
                List.generate(
                  choosedServer.areas!.length > 10 ? 10 : choosedServer.areas!.length,
                  (index) => choosedServer.areas!.elementAt(index),
                ),
              );
              searchArea = areas;
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
        "Area",
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
                    thingToSearch: "Area",
                    searchController: searchController,
                    search: (value) => search(value),
                  ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  child: Image.asset(
                    "assets/images/area/area.png",
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
      delegate: SliverChildListDelegate(List.generate(
        searchController.text.length == 0 ? areas.length : searchArea.length,
        (index) {
          int listLength;
          if (searchController.text.length == 0) {
            listLength = areas.length;
          } else {
            listLength = searchArea.length;
          }
          Area area = searchController.text.length == 0 ? areas.elementAt(index) : searchArea.elementAt(index);
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

              //BOX CONTAINER
              child: Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                width: MediaQuery.of(context).size.width * 0.8 > 310 ? MediaQuery.of(context).size.width * 0.8 : 310,
                height: 165,
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        //SERVER NAME AND IP NUMBER
                        Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "${area.name}\n",
                                style: TextStyle(
                                  fontFamily: "Nunito Sans",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text: area.ipNumber,
                                style: TextStyle(
                                  fontFamily: "Nunito Sans",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Color(myColors.secondaryTextColor()),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //CONNECTION STATUS
                        Container(
                          width: 70,
                          height: 15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: area.isConnected! ? Color(myColors.primaryGreen()) : Color(myColors.primaryRed())),
                          child: Text(
                            area.isConnected! ? "Connected" : "Disconnected",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Nunito Sans",
                              fontWeight: FontWeight.w700,
                              fontSize: 9,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),

                    //MAP IMAGE
                    SizedBox(
                      height: 95,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/area/map.png"),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),

                    //DOWNLOAD AND UPLOAD INFORMATION
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Download : ${area.download} Mbps",
                          style: TextStyle(
                            fontFamily: "Nunito Sans",
                            fontWeight: FontWeight.w700,
                            fontSize: 9,
                            color: Color(myColors.secondaryGreen()),
                          ),
                        ),
                        Text(
                          "Upload : ${area.upload} Kbps",
                          style: TextStyle(
                            fontFamily: "Nunito Sans",
                            fontWeight: FontWeight.w700,
                            fontSize: 9,
                            color: Color(myColors.darkGreen()),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      )),
    );
  }
}
