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
    if (json['customers'] != null) {
      customers = <Customer>[];
      json['customers'].forEach((item) {
        customers!.add(Customer.fromJson(item));
      });
    }
    if (json['areas'] != null) {
      areas = <Area>[];
      json['areas'].forEach((item) {
        areas!.add(Area.fromJson(item));
      });
    }
    if (json['payments'] != null) {
      payments = <Payment>[];
      json['payments'].forEach((item) {
        payments!.add(Payment.fromJson(item));
      });
    }
    if (json['queue'] != null) {
      queue = <Queue>[];
      json['queue'].forEach((item) {
        queue!.add(Queue.fromJson(item));
      });
    }
    income = Income.fromJson(json['income']);
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
    if (this.customers != null) {
      data['customers'] = this.customers!.map((v) => v.toJson()).toList();
    }
    if (this.areas != null) {
      data['areas'] = this.areas!.map((v) => v.toJson()).toList();
    }
    if (this.payments != null) {
      data['payments'] = this.payments!.map((v) => v.toJson()).toList();
    }
    if (this.queue != null) {
      data['queue'] = this.queue!.map((v) => v.toJson()).toList();
    }
    data['income'] = this.income!.toJson();
    return data;
  }
}
