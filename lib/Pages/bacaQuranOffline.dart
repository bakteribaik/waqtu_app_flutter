import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:waqtuu/Models/surahoffline_model.dart' as model;
import 'package:waqtuu/Pages/TafsirPage.dart';
import 'package:waqtuu/Service/surahoffline_service.dart';
import 'package:fluttertoast/fluttertoast.dart';


class QuranOfflinePage extends StatefulWidget {

  final bool isDarkMode;

  final int surahNumber;

  const QuranOfflinePage({ 
    Key? key ,
    required this.surahNumber,
    required this.isDarkMode,
    }) : super(key: key);

  @override
  _QuranOfflinePageState createState() => _QuranOfflinePageState();
}

class _QuranOfflinePageState extends State<QuranOfflinePage> {
  
  ScrollController _scrollController = ScrollController();

  final LColor = Color(0xff01937C);
  final DColor = Color(0xff2C3333);
  final BColor = Color(0xff395B64);

  QuranService quranService = QuranService();
  model.Quran quran = model.Quran();

  double Textsize = 24;

  bool isFetch = false;
  bool onInternet = false;
  bool playing = false;
  bool ayatPlaying = false;
  bool isAlfatiha = false;

  int? _index;

  AudioPlayer audioPlayer = AudioPlayer();

  _getData() async {
    quran = await quranService.getQuran();
    isFetch = true;
    setState(() {});
  }

  _alfatihaCheck(){
    if (widget.surahNumber == 1) {
      setState(() {
        isAlfatiha = true;
      });
    }else{
      setState(() {
        isAlfatiha = false;
      });
    }
  }

  _checkInternet() async {
    var result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      if (this.mounted) {
        setState(() {
        onInternet = true;
        });
      }
    } else {
      if (this.mounted) {
        setState(() {
        onInternet = false;
      });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _getData();
    Timer.periodic(Duration(seconds: 1), (Timer t) => _checkInternet());

    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.COMPLETED) {
       print('audio stop');
       setState(() {
         playing = false;
       }); 
      }
    });

    _alfatihaCheck();
    print(isAlfatiha);
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.release();
  }

  _playSurah(){
        if(playing == true){
          pauseSurah();
        }else{
          playSurah();
        }
  }


  _play(ayat) async {
    await audioPlayer.play("https://cdn.alquran.cloud/media/audio/ayah/ar.alafasy/$ayat");
    setState(() {
      ayatPlaying  = true;
    });
  }
  pauseAyat(){
    audioPlayer.pause();
    setState(() {
      ayatPlaying = false;
    });
  }
  playSurah() async {
    if (onInternet == true) {
        var i  = await audioPlayer.play('https://zulfikaralwi.my.id/wp-content/uploads/2022/02/${widget.surahNumber}.mp3');
        if (i == 1) {
          Fluttertoast.showToast(msg: 'Playing', backgroundColor: Colors.teal, textColor: Colors.white);
        }
        setState(() {
          playing = true;
        });
    } else {
        Fluttertoast.showToast(msg: 'need internet connection', backgroundColor: Colors.red, textColor: Colors.white,);
    }
  }
  pauseSurah(){
    audioPlayer.pause();
    setState(() {
      playing = false;
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        elevation: 0.0,
        leading: isFetch ? IconButton(onPressed: (){
          _playSurah();
        }, icon: playing ? Icon(Icons.pause_circle_outline_sharp, size: 26,) : Icon(Icons.play_circle_outline_rounded, size: 26,) ) : SizedBox(), //button play all surah

        backgroundColor: widget.isDarkMode ? BColor : LColor,
        title: isFetch ? Container(
          child: Column(
            children: [
              Text('${quran.data![widget.surahNumber - 1].name!.transliteration!.id}', style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
              Text('${quran.data![widget.surahNumber - 1].revelation!.id} | ${quran.data![widget.surahNumber -1].numberOfVerses} ayat', style: TextStyle(fontSize: 10),),
            ],
          ),
        ) : Text('Loading ...'),
        centerTitle: true,
      ),
      body: isFetch ? Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 45),
        child: Stack(
          children: [
            Container(
              child: ListView.builder(        
                itemCount: quran.data![widget.surahNumber - 1].verses!.length,
                itemBuilder: (context, index){
                final _isSelected = index == _index;
                return ListTile(
                  visualDensity: VisualDensity.comfortable,

                  tileColor: widget.isDarkMode ? quran.data![widget.surahNumber -1].verses![index].number!.inSurah!.isEven ? BColor : DColor : quran.data![widget.surahNumber -1].verses![index].number!.inSurah!.isEven ? Colors.transparent : Colors.teal[50],

                    title:  Container( //TEKS ARAB
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                      child: Text('${quran.data![widget.surahNumber - 1].verses![index].text!.arab}', textAlign: TextAlign.end, style: TextStyle(
                          fontSize: Textsize,
                          fontFamily: 'Misbah',
                          height: 2.3,
                          color: widget.isDarkMode ? Colors.white : Colors.black87
                        ),),
                    ),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(child: Text('${quran.data![widget.surahNumber - 1].verses![index].text!.transliteration!.en}', textAlign: TextAlign.end, style: TextStyle(
                              color: widget.isDarkMode ? Colors.white : Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: Textsize - 12,
                            ),),),

                            IconButton(onPressed: (){
                                if (onInternet == true) {
                                  _play(quran.data![widget.surahNumber-1].verses![index].number!.inQuran!);
                                }else{
                                  Fluttertoast.showToast(msg: 'need internet connection', textColor: Colors.white, backgroundColor: Colors.red);
                                }
                            }, icon: Icon(Icons.music_note_outlined, color: Colors.grey,))
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(child: Text('${quran.data![widget.surahNumber - 1].verses![index].translation!.id} ', textAlign: TextAlign.end, style: TextStyle(
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                              fontSize: Textsize - 12,
                            ),),),

                            IconButton(onPressed: (){
                                Navigator.push(context, 
                                  MaterialPageRoute(builder: (contex) => TafsirPages(
                                    isDarkMode : widget.isDarkMode,
                                    ayatNumber : quran.data![widget.surahNumber - 1].verses![index].number!.inSurah!,
                                    SurahNumber: widget.surahNumber,
                                  )));
                            }, icon: Icon(Icons.info_outline, color: Colors.grey,)),
                          ],
                        )
                      ],
                    ),
                    trailing: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      //  color: Colors.red,
                      image: DecorationImage(
                        image: AssetImage('assets/images/ayat_frame.png')
                      )
                    ),
                    child: Center(child: Text(quran.data![widget.surahNumber -  1].verses![index].number!.inSurah.toString(), style: TextStyle(color:Color(0xff2EB086), fontFamily: 'Misbah'),),)
                  ),

                );
              }),
                  ),

                  Positioned(
                    right: 0,
                    bottom: 50,
                    child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      width: 50,
                      decoration: BoxDecoration(
                        color: widget.isDarkMode ? BColor : LColor,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1,3),
                            blurRadius: 5
                          )
                        ]
                      ),
                      child: Column(
                        children: [
                          IconButton(onPressed: (){
                            setState(() {
                            Textsize++;
                            });
                          }, icon: Icon(Icons.control_point_outlined, color: Colors.white,),),
                          Divider(),
                          IconButton(onPressed: (){
                            setState(() {
                            Textsize--;
                            });
                          }, icon: Icon(Icons.remove_circle_outline), color: Colors.white,),
                        ],
                      )
                    )
            ),
          ],
        )
      ),

          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            width: MediaQuery.of(context).size.width,
            color: Colors.teal.shade900,
            child: isAlfatiha ? 
                      Text('${quran.data![0].name!.long}', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Misbah'),) : 
                      Text('${quran.data![1].preBismillah!.text!.arab}', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Misbah'),),
          )
        ],
      ) : SizedBox()
    );
  }
}