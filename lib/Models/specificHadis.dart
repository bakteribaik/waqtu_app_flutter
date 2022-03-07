class SpecificHadis {
  int? code;
  String? message;
  Data? data;
  bool? error;

  SpecificHadis({this.code, this.message, this.data, this.error});

  SpecificHadis.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : new Data.fromJson(json['data'] ?? 'Data Tidak Ada');
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = this.error;
    return data;
  }
}

class Data {
  String? name;
  String? id;
  int? available;
  Contents? contents;

  Data({this.name, this.id, this.available, this.contents});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    available = json['available'];
    contents = json['contents'] != null
        ? new Contents.fromJson(json['contents'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['available'] = this.available;
    if (this.contents != null) {
      data['contents'] = this.contents!.toJson();
    }
    return data;
  }
}

class Contents {
  int? number;
  String? arab;
  String? id;

  Contents({this.number, this.arab, this.id});

  Contents.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    arab = json['arab'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['arab'] = this.arab;
    data['id'] = this.id;
    return data;
  }
}
