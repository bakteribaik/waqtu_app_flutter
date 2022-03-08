import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:waqtuu/Models/listHadist_model.dart';
import 'package:waqtuu/Models/specificHadis.dart';

class ListHadistService{
  Future<ListHadist> fetchData() async {
    final url = 'https://api.hadith.sutanlab.id/books';
    try { 
       final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return ListHadist.fromJson(jsonDecode(response.body));
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }
  
}

class specificHadisService{
  Future<SpecificHadis> fetchData(String nama,int nomor)async{
    try {
      final uri = 'https://api.hadith.sutanlab.id/books/$nama/$nomor';
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        return SpecificHadis.fromJson(jsonDecode(response.body));
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }
}