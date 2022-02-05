import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:waqtuu/Models/waqtu_model.dart';

class DataService {
  Future<Sholat> fetchData(String CityName, String Date) async {

    final url = 'https://api.pray.zone/v2/times/day.json?city=$CityName&date=$Date';

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