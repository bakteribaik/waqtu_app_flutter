import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waqtuu/Models/surahoffline_model.dart' as model;
import 'package:waqtuu/Pages/TafsirPage.dart';
import 'package:waqtuu/Service/surahoffline_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:path_provider/path_provider.dart';


class QuranOfflinePage extends StatefulWidget {

  final int surahNumber;

  const QuranOfflinePage({ 
    Key? key ,
    required this.surahNumber,
    }) : super(key: key);

  @override
  _QuranOfflinePageState createState() => _QuranOfflinePageState();
}

class _QuranOfflinePageState extends State<QuranOfflinePage> {

   QuranService quranService = QuranService();
  model.Quran quran = model.Quran();

  double Textsize = 24;

  bool isFetch = false;
  bool Internet = false;
  bool playing = false;

  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();

  int? ayat;
  String? ayatName;
  int? ayatNumber;
  int index = 0;
  int panjangSurah = 0;
  int ayatt = 1;
  int savedIndex = 0;



  _getData() async {
    quran = await quranService.getQuran();
    isFetch = true;
    savedIndex = quran.data![widget.surahNumber-1].verses![0].number!.inQuran!;
    index = quran.data![widget.surahNumber-1].verses![0].number!.inQuran!;
    panjangSurah = quran.data![widget.surahNumber - 1].numberOfVerses!;
    print(index.toString() + " | " + panjangSurah.toString());
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getData();
    audioCache = AudioCache(fixedPlayer: audioPlayer);
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.release();
    audioPlayer.dispose();
    audioCache.clearAll();
  }

  play(ayat) async {
    if(await Connectivity().checkConnectivity() == ConnectivityResult.wifi || await Connectivity().checkConnectivity() == ConnectivityResult.mobile){
        await audioPlayer.play("https://cdn.alquran.cloud/media/audio/ayah/ar.alafasy/$ayat");
        Fluttertoast.showToast(msg: 'Surat ${ayatName} ayat ${ayatNumber}', backgroundColor: Color(0xff2EB086), textColor: Colors.white);
    }else{
      Internet = true;
      Fluttertoast.showToast(msg: 'No internet Connection', backgroundColor: Color(0xffB8045E), textColor: Colors.white,);
    }
  }

  // playingAll(){
  //   _playLocal();
  //   _getstate();
  // }

  // _playLocal(){
  //   if (playing) {
  //       _pauseLocal();
  //   }else{
  //     _getAudio();
  //   }
  // }

  // _getAudio(){
  //   audioCache.play('audio/${widget.surahNumber}.mp3');
  //   setState(() {
  //     playing = true;
  //   });
  // }

  // _pauseLocal() async {
  //   var i = await audioPlayer.pause();
  //   if(i == 1) {
  //     setState(() {
  //        playing = false;
  //     });
  //   }
  // }

  // _stopLocal(){
  //   audioPlayer.release();
  // }

  // _getstate(){
  //   audioPlayer.onPlayerStateChanged.listen((PlayerState s) {
  //     if (s == PlayerState.COMPLETED) {
  //       setState(() {
  //         playing = false;
  //       });
  //     }
  //   });
  // }


  // _playAllSurah(){
  //   isComplete();
  //   plays(index);
  // }

  // plays(index){
  //   var url = "https://cdn.alquran.cloud/media/audio/ayah/ar.alafasy/$index";
  //       if (panjangSurah > ayatt) {
  //         audioPlayer.play(url);
  //             setState(() {
  //               playing = true;
  //             });
  //         }else{
  //           stopPlay();
  //         }
  // }

  // isComplete()  {
  //   audioPlayer.onPlayerCompletion.listen((event) {
  //      setState(() {
  //        plays(index = index + 1);
  //        ayatt++;
  //      });
  //   });
  // }

  // stopPlay(){
  //   print('music Stop');
  //   audioPlayer.release();
  //   Navigator.of(context);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(

        leading: isFetch ? IconButton(onPressed: (){
          Fluttertoast.showToast(msg: 'Coming Soon');
        }, icon: playing ? Icon(Icons.pause_circle_outline_sharp) : Icon(Icons.play_circle_outline_rounded) ) : SizedBox(), //button play all surah

        backgroundColor: Color(0xff2EB086),
        title: isFetch ? Container(
          child: Column(
            children: [
              Text('${quran.data![widget.surahNumber - 1].name!.transliteration!.id}', style: TextStyle(fontWeight: FontWeight.bold),),
              Text('${quran.data![widget.surahNumber - 1].revelation!.id} | ${quran.data![widget.surahNumber -1].numberOfVerses} ayat', style: TextStyle(fontSize: 10),),
            ],
          ),
        ) : Text('Loading ...'),
        actions: [
          Row(
            children: [
                    IconButton(onPressed: (){
                    setState(() {
                      Textsize--;
                    });
                }, icon: Icon(Icons.remove_circle_outline)),

                IconButton(onPressed: (){
                    setState(() {
                      Textsize++;
                    });
                }, icon: Icon(Icons.control_point)),
            ],
          )
        ],
        centerTitle: true,
      ),
      body: isFetch ? Container(
        padding: EdgeInsets.only(left: 5,),
        child: ListView.builder(
          itemCount: quran.data![widget.surahNumber - 1].verses!.length,
          itemBuilder: (context, index){
           return ListTile(
            
             tileColor: quran.data![widget.surahNumber -1].verses![index].number!.inSurah!.isEven ? Colors.transparent : Colors.green[50],
              onLongPress: (){
                Navigator.push(context, 
                MaterialPageRoute(builder: (contex) => TafsirPages(
                  ayatNumber : quran.data![widget.surahNumber - 1].verses![index].number!.inSurah!,
                  SurahNumber: widget.surahNumber,
                )));
              },
              onTap: (){
                ayatNumber = quran.data![widget.surahNumber - 1].verses![index].number!.inSurah;
                ayatName = quran.data![widget.surahNumber - 1].name!.transliteration!.id;
                  play(quran.data![widget.surahNumber-1].verses![index].number!.inQuran!);
                },
              title:  Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                child: Text('${quran.data![widget.surahNumber - 1].verses![index].text!.arab}', textAlign: TextAlign.end, style: TextStyle(
                    fontSize: Textsize,
                    fontFamily: 'Misbah'
                  ),),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 5,),
                  Text('${quran.data![widget.surahNumber - 1].verses![index].text!.transliteration!.en}', textAlign: TextAlign.end, style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: Textsize - 12,
                  ),),
                  Divider(),
                  Text('${quran.data![widget.surahNumber - 1].verses![index].translation!.id}', textAlign: TextAlign.end, style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                    fontSize: Textsize - 12,
                  ),),
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
             
              child: Center(child: Text(quran.data![widget.surahNumber -  1].verses![index].number!.inSurah.toString(), style: TextStyle(color:Color(0xff2EB086)),),)
            )
           );
        }),
      ) : SizedBox()
    );
  }
}