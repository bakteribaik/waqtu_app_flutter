import 'package:flutter/material.dart';

import 'package:waqtuu/Service/Surah_service.dart';
import 'package:waqtuu/Models/surah_model.dart' as sr;

class SurahPages extends StatefulWidget {
 final String ayatNumber;
  

  const SurahPages({ 
    Key? key,
    required this.ayatNumber
   }) : super(key: key);


  @override
  _SurahPagesState createState() => _SurahPagesState();
}

class _SurahPagesState extends State<SurahPages> {

  

  SurahServices surahServices = SurahServices();
  sr.Surah surah = sr.Surah();

  bool isFetch = false;

  _getData() async {
    surah = await surahServices.getSurah(widget.ayatNumber);
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
        title: isFetch ? Text('${surah.data!.name!.transliteration!.id}') : Text('Loading....'),
        centerTitle: true,
      ),
      body: isFetch ? Container(
        child: ListView.builder(
        itemCount: surah.data!.verses!.length,
        itemBuilder: (context, index){
          return ListTile(
            trailing: Text('${surah.data!.verses![index].text!.arab}'),
          );
      }),
      ) : SizedBox()
    );
  }
}