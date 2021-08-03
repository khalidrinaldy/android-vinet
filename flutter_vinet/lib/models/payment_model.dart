class Payment {
  //Information
  String? name;
  String? paymentDate;
  String? address;
  String? phone;

  //Packet
  String? packetType;
  int? packetSpeed;
  int? packetPrice;

  Payment({this.name, this.paymentDate, this.address, this.phone, this.packetType, this.packetSpeed, this.packetPrice});

  Payment.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    paymentDate = json['paymentDate'];
    address = json['address'];
    phone = json['phone'];
    packetType = json['packetType'];
    packetSpeed = json['packetSpeed'];
    packetPrice = json['packetPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['paymentDate'] = this.paymentDate;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['packetType'] = this.packetType;
    data['packetSpeed'] = this.packetSpeed;
    data['packetPrice'] = this.packetPrice;
    return data;
  }
}