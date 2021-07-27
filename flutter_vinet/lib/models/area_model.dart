class Area {
  String? name;
  String? ipNumber;
  bool? isConnected;
  int? download;
  int? upload;

  Area({this.name, this.ipNumber, this.isConnected, this.download, this.upload});

  Area.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    ipNumber = json['ipNumber'];
    isConnected = json['isConnected'];
    download = json['download'];
    upload = json['upload'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['ipNumber'] = this.ipNumber;
    data['isConnected'] = this.isConnected;
    data['download'] = this.download;
    data['upload'] = this.upload;
    return data;
  }
}
