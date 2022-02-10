import 'package:flutter/material.dart';
import 'package:waqtuu/Models/surahoffline_model.dart' as model;
import 'package:waqtuu/Service/surahoffline_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

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

  AudioPlayer audioPlayer = AudioPlayer();

  int? ayat;
  String? ayatName;
  int? ayatNumber;

  play(ayat) async {
    if(await Connectivity().checkConnectivity() == ConnectivityResult.wifi || await Connectivity().checkConnectivity() == ConnectivityResult.mobile){
        await audioPlayer.play("https://cdn.alquran.cloud/media/audio/ayah/ar.alafasy/$ayat");
        Fluttertoast.showToast(msg: 'Surat ${ayatName} ayat ${ayatNumber}', backgroundColor: Color(0xff2EB086), textColor: Colors.white);
    }else{
      Internet = true;
      Fluttertoast.showToast(msg: 'No internet Connection', backgroundColor: Color(0xffB8045E), textColor: Colors.white,);
    }
  }

  QuranService quranService = QuranService();
  model.Quran quran = model.Quran();

  double Textsize = 24;

  bool isFetch = false;
  bool Internet = false;

  _getData() async {
    quran = await quranService.getQuran();
    isFetch = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.stop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Color(0xff2EB086),
        title: isFetch ? Container(
          child: Column(
            children: [
              Text('${quran.data![widget.surahNumber - 1].name!.transliteration!.id}', style: TextStyle(fontWeight: FontWeight.bold),),
              Text('${quran.data![widget.surahNumber - 1].revelation!.id}', style: TextStyle(fontSize: 10),),
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
                    print(Textsize);
                }, icon: Icon(Icons.zoom_out)),

                IconButton(onPressed: (){
                    setState(() {
                      Textsize++;
                    });
                    print(Textsize);
                }, icon: Icon(Icons.zoom_in)),
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
              onTap: (){
                ayatNumber = quran.data![widget.surahNumber - 1].verses![index].number!.inSurah;
                ayatName = quran.data![widget.surahNumber - 1].name!.transliteration!.id;
                  play(quran.data![widget.surahNumber-1].verses![index].number!.inQuran!);
                },
              title: Text('${quran.data![widget.surahNumber - 1].verses![index].text!.arab}', textAlign: TextAlign.end, style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Textsize,
              ),),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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
              trailing: CircleAvatar(
                backgroundColor: Color(0xff2EB086) ,
                maxRadius: 15,
                child: Text('${quran.data![widget.surahNumber - 1].verses![index].number!.inSurah}', style: TextStyle(color: Colors.white),),
              ),
           );
        }),
      ) : SizedBox()
    );
  }
}