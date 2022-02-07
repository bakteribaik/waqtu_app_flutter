

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:waqtuu/Models/surah_model.dart';


class SurahServices {
  Future<Surah> getSurah(String input) async {

    final url = 'https://api.quran.sutanlab.id/surah/$input';
    final response = await http.get(Uri.parse(url));
    return Surah.fromJson(jsonDecode(response.body));
  }
}