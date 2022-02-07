import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:waqtuu/Models/listSurah_model.dart';


class ListSurahService {
  Future<ListSurah> getSurah() async {
    final response = await rootBundle.loadString('assets/data/ListOfSurah.json');
    return ListSurah.fromJson(jsonDecode(response));
  }
}