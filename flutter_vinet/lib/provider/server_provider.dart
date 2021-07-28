import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ServerProvider with ChangeNotifier{
  List<Map<String, dynamic>>? servers;

  getServerData() async {
    var response = await rootBundle.loadString("assets/data/dummy.json");
    var jsonData = jsonDecode(response);

    for (var s in jsonData) {
      servers!.add(s);
    }

    notifyListeners();
  }

  ServerProvider() {
    getServerData();
  }
}