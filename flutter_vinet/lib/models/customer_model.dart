class Customer {
  //Connection
  String? name;
  String? id;
  String? ipNumber;
  bool? isConnected;
  String? packetType;
  int? packetSpeed;
  int? packetPrice;

  double? upload;
  double? download;

  //Payment
  bool? isPaid;

  //Information
  String? type;
  String? joinDate;
  String? address;
  String? phone;

  Customer({this.name, this.id, this.ipNumber, this.isConnected, this.packetType, this.packetSpeed, this.packetPrice, this.upload, this.download,
  this.isPaid, this.type, this.joinDate, this.address, this.phone});

  Customer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    ipNumber = json['ipNumber'];
    isConnected = json['isConnected'];
    packetType = json['packetType'];
    packetSpeed = json['packetSpeed'];
    packetPrice = json['packetPrice'];
    upload = json['upload'];
    download = json['download'];
    isPaid = json['isPaid'];
    type = json['type'];
    joinDate = json['joinDate'];
    address = json['address'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['ipNumber'] = this.ipNumber;
    data['isConnected'] = this.isConnected;
    data['packetType'] = this.packetType;
    data['packetSpeed'] = this.packetSpeed;
    data['packetPrice'] = this.packetPrice;
    data['upload'] = this.upload;
    data['download'] = this.download;
    data['isPaid'] = this.isPaid;
    data['type'] = this.type;
    data['joinDate'] = this.joinDate;
    data['address'] = this.address;
    data['phone'] = this.phone;
    return data;
  }
}