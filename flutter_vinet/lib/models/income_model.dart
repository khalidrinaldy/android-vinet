import 'package:intl/intl.dart';

final moneyFormat = new NumberFormat("#,##0", "en_US");
class Income {
  //Date
  String? month;
  int? year;

  //Budget
  int? totalBill;
  int? unpaid;
  int? paid;
  int? tax;
  int? managedServices;

  //get Income
  String? getIncome() {
    return "Rp.${moneyFormat.format(this.paid! - (this.tax! + this.managedServices!))}";
  }

  Income(
      {this.month,
      this.year,
      this.totalBill,
      this.unpaid,
      this.paid,
      this.tax,
      this.managedServices});

  Income.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    year = json['year'];
    totalBill = json['totalBill'];
    unpaid = json['unpaid'];
    paid = json['paid'];
    tax = json['tax'];
    managedServices = json['managedServices'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['year'] = this.year;
    data['totalBill'] = this.totalBill;
    data['unpaid'] = this.unpaid;
    data['paid'] = this.paid;
    data['tax'] = this.tax;
    data['managedServices'] = this.managedServices;
    return data;
  }
}