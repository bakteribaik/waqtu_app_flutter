

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:waqtuu/Models/surahoffline_model.dart';

class QuranService {
  Future<Quran> getQuran() async {
    final response = await rootBundle.loadString('assets/data/Surah.json');
    return Quran.fromJson(jsonDecode(response));
  }
}