import 'package:flutter/material.dart';
import 'package:waqtuu/Models/surahoffline_model.dart' as model;
import 'package:waqtuu/Service/surahoffline_service.dart';

class TafsirPages extends StatefulWidget {

  final int ayatNumber;
  final int SurahNumber;
  final bool isDarkMode;

  const TafsirPages({
    Key? key,
    required this.ayatNumber,
    required this.SurahNumber,
    required this.isDarkMode
    }) : super(key: key);

  @override
  _TafsirPagesState createState() => _TafsirPagesState();
}

class _TafsirPagesState extends State<TafsirPages> {

  final LColor = Color(0xff01937C);
  final DColor = Color(0xff2C3333);
  final BColor = Color(0xff395B64);

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
      backgroundColor: widget.isDarkMode ? BColor : Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: widget.isDarkMode ? Colors.transparent : Colors.teal,
        title: isFetch ?  Text('Tafsir surah ${quran.data![widget.SurahNumber - 1].name!.transliteration!.id} ayat ${widget.ayatNumber}', style: TextStyle(fontSize: 13),) : SizedBox(),
      ) ,
      body: isFetch ? 
           Center(
             child: Container(
               padding: EdgeInsets.all(10),
               child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: widget.isDarkMode ? DColor : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text('${quran.data![widget.SurahNumber - 1].verses![widget.ayatNumber - 1].tafsir!.id!.long}',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: widget.isDarkMode ? Colors.white70 : Colors.black54
                      ),
                      ),
                      ),
                ),
             )) : SizedBox(),
    );
  }
}