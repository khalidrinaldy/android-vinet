import 'package:flutter_vinet/models/area_model.dart';
import 'package:flutter_vinet/models/customer_model.dart';
import 'package:flutter_vinet/models/income_model.dart';
import 'package:flutter_vinet/models/payment_model.dart';
import 'package:flutter_vinet/models/queue_model.dart';

class Server {
  String? name;
  String? ipNumber;
  bool? isOnline;
  int? cpuLoad;
  int? ramLoad;
  int? profitSinceLastTarget;
  int? clientsLoad;
  double? tx;
  double? rx;

  List<Customer>? customers;
  List<Area>? areas;
  List<Payment>? payments;
  Income? income;
  List<Queue>? queue;

  Server({this.name, this.ipNumber, this.isOnline, this.cpuLoad, this.ramLoad, this.profitSinceLastTarget,
  this.clientsLoad, this.tx, this.rx, this.customers, this.areas, this.payments, this.income, this.queue});

  Server.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    ipNumber = json['ipNumber'];
    isOnline = json['isOnline'];
    cpuLoad = json['cpuLoad'];
    ramLoad = json['ramLoad'];
    profitSinceLastTarget = json['profitSinceLastTarget'];
    clientsLoad = json['clientsLoad'];
    tx = json['tx'];
    rx = json['rx'];
    customers = json['customers'];
    areas = json['areas'];
    payments = json['payments'];
    income = json['income'];
    queue = json['queue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['ipNumber'] = this.ipNumber;
    data['isOnline'] = this.isOnline;
    data['cpuLoad'] = this.cpuLoad;
    data['ramLoad'] = this.ramLoad;
    data['profitSinceLastTarget'] = this.profitSinceLastTarget;
    data['clientsLoad'] = this.clientsLoad;
    data['tx'] = this.tx;
    data['rx'] = this.rx;
    data['customers'] = this.customers;
    data['areas'] = this.areas;
    data['payments'] = this.payments;
    data['income'] = this.income;
    data['queue'] = this.queue;
    return data;
  }
}
