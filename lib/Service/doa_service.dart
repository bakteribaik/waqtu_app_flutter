

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:waqtuu/Models/doa_models.dart';
import 'package:waqtuu/Models/listSurah_model.dart';

class DoaService {
  Future<DoaModel> getDoa() async {
    final response = await rootBundle.loadString('assets/data/DoaSehariHari.json');
    return DoaModel.fromJson(jsonDecode(response));
  }
}