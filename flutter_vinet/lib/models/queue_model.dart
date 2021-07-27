class Queue {
  String? sender;
  String? date;
  String? packetType;
  int? packetSpeed;
  String? area;
  String? address;
  String? phone;

  Queue(
      {this.sender,
      this.date,
      this.packetType,
      this.packetSpeed,
      this.area,
      this.address,
      this.phone});

  Queue.fromJson(Map<String, dynamic> json) {
    sender = json['sender'];
    date = json['date'];
    packetType = json['packetType'];
    packetSpeed = json['packetSpeed'];
    area = json['area'];
    address = json['address'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sender'] = this.sender;
    data['date'] = this.date;
    data['packetType'] = this.packetType;
    data['packetSpeed'] = this.packetSpeed;
    data['area'] = this.area;
    data['address'] = this.address;
    data['phone'] = this.phone;
    return data;
  }
}