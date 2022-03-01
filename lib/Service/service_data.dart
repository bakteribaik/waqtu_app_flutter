import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:waqtuu/Models/asma_models.dart';
import 'package:waqtuu/Models/hij_models.dart';
import 'package:waqtuu/Models/waqtu_model.dart';

class DataService {
  Future<Sholat> fetchData(String long, String lat, String Date) async {

    final url = 'https://api.pray.zone/v2/times/day.json?longitude=106.7162167&latitude=-6.2996323&elevation=333&date=2022-02-12';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
          return Sholat.fromJson(jsonDecode(response.body));
        } else {
          throw Exception('error');
      }
    } catch (e) {
      rethrow;
    }
  }
}

class HijService {
  Future<HijYear> fetchData(String date) async {
    final url = 'https://api.aladhan.com/v1/gToH?date=$date';
    try{
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return HijYear.fromJson(jsonDecode(response.body));
      }else{
        throw Exception();
      }
    } on SocketException {
      rethrow;
    }
  }
}

class AsmaService{
  Future<AsmaModel> fetchData() async {
    final response = await rootBundle.loadString('assets/data/AsmaulHusna.json');
    return AsmaModel.fromJson(jsonDecode(response));
  }
}