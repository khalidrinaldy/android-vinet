class Info {
  String? name;
  String? ipNumber;
  bool? isOnline;
  int? cpuLoad;
  int? ramLoad;
  int? profitSinceLastTarget;
  int? clientsLoad;
  double? tx;
  double? rx;

  Info({this.name, this.ipNumber, this.isOnline, this.cpuLoad, this.ramLoad, this.profitSinceLastTarget,
  this.clientsLoad, this.tx, this.rx,});

  Info.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    ipNumber = json['ipNumber'];
    isOnline = json['isOnline'];
    cpuLoad = json['cpuLoad'];
    ramLoad = json['ramLoad'];
    profitSinceLastTarget = json['profitSinceLastTarget'];
    clientsLoad = json['clientsLoad'];
    tx = json['tx'];
    rx = json['rx'];
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
    return data;
  }
}