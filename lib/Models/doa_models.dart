class DoaModel {
  List<Doa>? doa;

  DoaModel({this.doa});

  DoaModel.fromJson(Map<String, dynamic> json) {
    if (json['doa'] != null) {
      doa = <Doa>[];
      json['doa'].forEach((v) {
        doa!.add(new Doa.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doa != null) {
      data['doa'] = this.doa!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Doa {
  String? judul;
  String? arab;
  String? latin;
  String? arti;
  String? footnote;

  Doa(
      {
      this.judul,
      this.arab,
      this.latin,
      this.arti,
      this.footnote,
      });

  Doa.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    arab = json['arab'];
    latin = json['latin'];
    arti = json['arti'];
    footnote = json['footnote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul'] = this.judul;
    data['arab'] = this.arab;
    data['latin'] = this.latin;
    data['arti'] = this.arti;
    data['footnote'] = this.footnote;
    return data;
  }
}
