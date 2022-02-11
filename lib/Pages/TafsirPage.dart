import 'package:flutter/material.dart';
import 'package:waqtuu/Models/surahoffline_model.dart' as model;
import 'package:waqtuu/Service/surahoffline_service.dart';

class TafsirPages extends StatefulWidget {

  final int ayatNumber;
  final int SurahNumber;

  const TafsirPages({
    Key? key,
    required this.ayatNumber,
    required this.SurahNumber,
    }) : super(key: key);

  @override
  _TafsirPagesState createState() => _TafsirPagesState();
}

class _TafsirPagesState extends State<TafsirPages> {

  QuranService quranService = QuranService();
  model.Quran quran = model.Quran();

  bool isFetch = false;

  _getData() async {
    quran = await quranService.getQuran();
    setState(() {});
    isFetch = true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2EB086),
        title: isFetch ?  Text('Tafsir surah ${quran.data![widget.SurahNumber - 1].name!.transliteration!.id} ayat ${widget.ayatNumber}', style: TextStyle(fontSize: 13),) : SizedBox(),
      ) ,
      body: isFetch ? 
           Center(
             child: Container(
               padding: EdgeInsets.all(10),
               child: SingleChildScrollView(
             scrollDirection: Axis.vertical,
             child: Text('${quran.data![widget.SurahNumber - 1].verses![widget.ayatNumber - 1].tafsir!.id!.long}'),
             ),
             )) : SizedBox(),
    );
  }
}