import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';
import 'package:waqtuu/MODELS/ListQuranModel/ListQuranModel.dart';
import 'package:waqtuu/SCREEN/Quran/Quran.dart';
import 'package:waqtuu/SERVICE/LocalDataFetch.dart';

class ListQuran extends StatefulWidget {
  const ListQuran({Key? key}) : super(key: key);

  @override
  State<ListQuran> createState() => _ListQuranState();
}

class _ListQuranState extends State<ListQuran> {

  ListQuranModel data = ListQuranModel();
  LocalData localData = LocalData();
  List result = [];

  String query = '';
  int nilaiIndex = 0;
  bool isFetch = false;
  bool playing = false;

  AudioPlayer audioPlayer = AudioPlayer();

  _getData() async {
    data = await localData.listQuran();
    setState(() {
      isFetch = true;
    });
  }

  _playAudio(){
    if (playing == false) {
      setState(() {
        playing = true;
      });
      audioPlayer.play();
    }else{
      setState(() {
        playing = false;
      });
      audioPlayer.pause();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _getData();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey
        ),
        backgroundColor: Colors.transparent,
        title: Text('Qur`an', style: TextStyle(color: Color.fromARGB(255, 50, 172, 111), fontWeight: FontWeight.bold, fontSize: 15),),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.only(left: 20, right: 10),
              width: MediaQuery.of(context).size.width/1.2,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(30)
              ),
              child: TextField(
                onChanged: (value){
                  setState(() {
                    query = value;
                    _searching(query);
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Cari Surah',
                  suffixIcon: Icon(Icons.search),
                  border: InputBorder.none
                ),
              ),
            ),
            SizedBox(height: 20,),
            isFetch ?
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width/1.1,
                child: query.isEmpty ? onQuery() : onSearch()
              ),
            ) : Center(child: Text('Loading...'),)
          ],
        ),
      ),
    );
  }
  _searching(String input){
    result = data.data!.where((quran) => quran.name!.translation!.id!.toLowerCase().replaceAll('-', ' ').contains(input.toLowerCase())).toList();
  }

  onSearch(){
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: result.length,
      itemBuilder: (context, index){
        final quran = result[index];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            children: [
              ListTile(
                onTap: (){
                  FocusManager.instance.primaryFocus?.unfocus();
                  setState(() {
                    playing = false;
                    nilaiIndex = 0;
                  });
                  audioPlayer.stop();
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QuranPages(
                    quranNumber: quran.number!.toInt(),
                  )));
                },
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/ayat_frame.png'),
                  backgroundColor: Colors.transparent,
                  child: Text(quran.number.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.green[200]),),
                ),
                title: Row(
                  children: [
                     Text(quran.name!.transliteration!.id.toString().replaceAll('-', ' '), style: TextStyle(fontSize: 14),),
                     SizedBox(width: 5,),
                     GestureDetector(
                      onTap: () async {
                        try{
                          final result = await InternetAddress.lookup('google.com');
                          if (result.isNotEmpty) {
                            final result = audioPlayer.setUrl('https://zulfikaralwi.my.id/wp-content/uploads/2022/02/${quran.number}.mp3');
                            if (result != null) {
                              setState(() {
                                nilaiIndex = index;
                              });
                                _playAudio();
                            }else{
                                Fluttertoast.showToast(msg: 'server stream error!');
                            }
                          }
                        }catch (e){
                          Fluttertoast.showToast(msg: 'Tidak terhubung internet');
                        }
                      },
                       child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[50],
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Center(child: playing == true ? nilaiIndex == index ? Icon(Icons.pause, size: 12, color: Colors.lightBlue,) : Icon(Icons.music_note, size: 12, color: Colors.lightBlue,) : Icon(Icons.music_note, size: 12, color: Colors.lightBlue,)),
                      ),
                    )
                  ],
                ),
                subtitle: Text(quran.name!.translation!.id.toString(), style: TextStyle(fontSize: 12, color: Colors.blueGrey),),
                trailing: Text(quran.name!.short.toString(), style: TextStyle(fontSize: 28, color: Colors.black54),),
              ),
            ],
          )
        );
      }
    );
  }

  onQuery(){
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: data.data!.length,
      itemBuilder: (context, index){
        var quran = data.data![index];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            children: [
              ListTile(
                onTap: (){
                  FocusManager.instance.primaryFocus?.unfocus();
                  setState(() {
                    playing = false;
                    nilaiIndex = 0;
                  });
                  audioPlayer.stop();
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QuranPages(
                    quranNumber: quran.number!.toInt(),
                  )));
                },
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/ayat_frame.png'),
                  backgroundColor: Colors.transparent,
                  child: Text(quran.number.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.green[200]),),
                ),
                title: Row(
                  children: [
                     Text(quran.name!.transliteration!.id.toString().replaceAll('-', ' '), style: TextStyle(fontSize: 14),),
                     SizedBox(width: 5,),
                     GestureDetector(
                      onTap: () async {
                        try{
                          final result = await InternetAddress.lookup('google.com');
                          if (result.isNotEmpty) {
                            final result = audioPlayer.setUrl('https://zulfikaralwi.my.id/wp-content/uploads/2022/02/${quran.number}.mp3');
                            if (result != null) {
                              setState(() {
                                nilaiIndex = index;
                              });
                                _playAudio();
                            }else{
                                Fluttertoast.showToast(msg: 'server stream error!');
                            }
                          }
                        }catch (e){
                          Fluttertoast.showToast(msg: 'Tidak terhubung internet');
                        }
                      },
                       child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[50],
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Center(child: playing == true ? nilaiIndex == index ? Icon(Icons.pause, size: 12, color: Colors.lightBlue,) : Icon(Icons.music_note, size: 12, color: Colors.lightBlue,) : Icon(Icons.music_note, size: 12, color: Colors.lightBlue,)),
                      ),
                    )
                  ],
                ),
                subtitle: Text(quran.name!.translation!.id.toString(), style: TextStyle(fontSize: 12, color: Colors.blueGrey),),
                trailing: Text(quran.name!.short.toString(), style: TextStyle(fontSize: 28, color: Colors.black54, fontFamily: 'Misbah'),),
              ),
            ],
          )
        );
      }
    );
  }
}

