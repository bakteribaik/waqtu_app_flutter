class AsmaulHusnaModel {
  List<Data>? data;

  AsmaulHusnaModel({this.data});

  AsmaulHusnaModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? urutan;
  String? latin;
  String? arab;
  String? arti;

  Data({this.urutan, this.latin, this.arab, this.arti});

  Data.fromJson(Map<String, dynamic> json) {
    urutan = json['urutan'];
    latin = json['latin'];
    arab = json['arab'];
    arti = json['arti'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['urutan'] = this.urutan;
    data['latin'] = this.latin;
    data['arab'] = this.arab;
    data['arti'] = this.arti;
    return data;
  }
}
