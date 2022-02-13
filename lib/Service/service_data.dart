import 'dart:convert';

import 'package:http/http.dart' as http;
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