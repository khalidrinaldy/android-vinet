import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vinet/models/server_model.dart';

class ServerProvider with ChangeNotifier {
  int? choosedIndex = 0;
  List<Server>? servers = [];

  chooseServer(int value) {
    this.choosedIndex = value;
    notifyListeners();
  }

  getServerList() async {
    var response = await rootBundle.loadString("assets/data/dummy.json");
    List<dynamic> jsonData = json.decode(response);

    for (var i = 0; i < jsonData.length; i++) {
      Server server = Server.fromJson(jsonData[i]);
      servers!.add(server);
    }
    notifyListeners();
    return servers;
  }

  Stream streamServers(Duration refreshTime) async* {
    while (true) {
      await Future.delayed(refreshTime);
      yield await getServerList();
    }
  }

  ServerProvider() {}
}
