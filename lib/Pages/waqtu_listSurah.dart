import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:waqtuu/Models/listSurah_model.dart';
import 'package:waqtuu/Pages/bacaQuranOffline.dart';
import 'package:waqtuu/Service/listSurah_service.dart';
import 'package:url_launcher/url_launcher.dart';


class ListSurahPage extends StatefulWidget {
  final bool isDarkMode;
  const ListSurahPage({
    Key? key,
    required this.isDarkMode,
    }) : super(key: key);
  @override
  _ListSurahPageState createState() => _ListSurahPageState();
}

class _ListSurahPageState extends State<ListSurahPage> {

  String query = '';
  List<Data> result = [];

  TextEditingController controller = TextEditingController();

  final LColor = Color(0xff01937C);
  final DColor = Color(0xff2C3333);
  final BColor = Color(0xff395B64);

  ListSurahService listSurahService = ListSurahService();
  ListSurah listSurah = ListSurah();

  bool isFetch = false;

  _getData() async {
    listSurah = await listSurahService.getSurah();
    setState(() {});
    isFetch = true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
    
  }

  int ayatNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode ? DColor : LColor,
     appBar: AppBar(
        centerTitle: true,
        title: Text("Waqtu Digital Al Qur'an", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: isFetch ? Container(
        decoration: BoxDecoration(
          color: widget.isDarkMode ? BColor : Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
        ),
        margin: EdgeInsets.only(top: 30),
        padding: EdgeInsets.only(left: 5, right: 5, top: 10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                textInputAction: TextInputAction.done,
                controller: controller,
                decoration: InputDecoration(
                  icon: Icon(Icons.search_rounded, color: widget.isDarkMode ? Colors.white : LColor,),
                  hintText: 'Cari Surah',
                  hintStyle: TextStyle(fontSize: 13, color: widget.isDarkMode ? Colors.white : Colors.grey),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  color: widget.isDarkMode ? Colors.white : Colors.grey
                ),
                onChanged: (q){
                  setState(() {
                    query = q;
                    _searchResult(query);
                    print(result);
                  });
                },
              ),
            ),
            Divider(),
            Expanded(
              child: query.isNotEmpty ? _onSearch() : _onQuery()
            )
          ],
        )
      ) : SizedBox(),
    ) ;
  }

  _onSearch(){
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (context, index){
        return ListTile(
          onTap: (){
                    ayatNumber = result[index].number!;
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => QuranOfflinePage(
                      isDarkMode : widget.isDarkMode,
                      surahNumber : ayatNumber,
                    ))
                    ); // ketika list surah di tekan
                  },
          contentPadding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${result[index].name!.transliteration!.id}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: widget.isDarkMode ? Colors.white : Colors.black54),),
              Text('${result[index].name!.translation!.id}', style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          title: Text('${result[index].name!.short}', textAlign: TextAlign.end, style: TextStyle(fontSize: 24,fontFamily: 'Misbah', color: widget.isDarkMode ? Colors.white : Colors.black),),
          trailing: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      //  color: Colors.red,
                      image: DecorationImage(
                        image: AssetImage('assets/images/ayat_frame.png')
                      )
                    ),
                  
                    child: Center(child: Text(result[index].number.toString(), style: TextStyle(color: widget.isDarkMode ? Colors.white : Color(0xff2EB086), fontFamily: 'Misbah'),),)
                  )
        );
      }
    );
  }

  _onQuery(){
    return ListView.builder(
              itemCount: listSurah.data!.length,
              itemBuilder: (context, index){
                return ListTile(
                  contentPadding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                  leading: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${listSurah.data![index].name!.transliteration!.id}', style: TextStyle(
                        color: widget.isDarkMode ? Colors.white : Colors.black54,
                        fontWeight: FontWeight.bold,
                      
                        fontSize: 15
                      ),),
                      Text('${listSurah.data![index].name!.translation!.id}', style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13
                      ),),
                    ],
                  ),
                  onTap: (){
                    ayatNumber = listSurah.data![index].number!;
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => QuranOfflinePage(
                      isDarkMode : widget.isDarkMode,
                      surahNumber : ayatNumber,
                    ))
                    ); // ketika list surah di tekan
                  },
                  title: Text('${listSurah.data![index].name!.short}', style: TextStyle(
                    fontSize: 24, 
                    fontFamily: 'Misbah',
                    color: widget.isDarkMode ? Colors.white : Colors.black), 
                    textAlign: TextAlign.end,), 
                  trailing: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      //  color: Colors.red,
                      image: DecorationImage(
                        image: AssetImage('assets/images/ayat_frame.png')
                      )
                    ),
                  
                    child: Center(child: Text(listSurah.data![index].number.toString(), style: TextStyle(color: widget.isDarkMode ? Colors.white : Color(0xff2EB086), fontFamily: 'Misbah'),),)
                  )
                );
              });
  }

   _searchResult(String query){
    result = listSurah.data!.where((data) => data.name!.transliteration!.id!.toLowerCase().contains(query.toLowerCase())).toList(); 
  }
}