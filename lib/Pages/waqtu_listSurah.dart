import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:waqtuu/Models/listSurah_model.dart';
import 'package:waqtuu/Pages/bacaQuranOffline.dart';
import 'package:waqtuu/Service/listSurah_service.dart';
import 'package:url_launcher/url_launcher.dart';


class ListSurahPage extends StatefulWidget {
  const ListSurahPage({ Key? key }) : super(key: key);

  @override
  _ListSurahPageState createState() => _ListSurahPageState();
}

class _ListSurahPageState extends State<ListSurahPage> {

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
     appBar: AppBar(
        centerTitle: true,
        title: Text("Suratul Qur'an", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
        elevation: 0.0,
        backgroundColor: Color(0xff2EB086),
        actions: [
          TextButton(
            onPressed: () async {
              final url = 'https://wa.me/6283808503597?text=hallo%20admin%20waqtu';
              if(await canLaunch(url) && await Connectivity().checkConnectivity() == ConnectivityResult.wifi && await Connectivity().checkConnectivity() == ConnectivityResult.wifi){
                await launch(url);
              }else(
                Fluttertoast.showToast(msg: 'No Internet Connection')
              );
            }, 
            child: Text('Need Help?', style: TextStyle(color: Colors.white),))
        ],
      ),
      body: isFetch ? Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: ListView.builder(
        itemCount: listSurah.data!.length,
        itemBuilder: (context, index){
          return ListTile(
            contentPadding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
            leading: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${listSurah.data![index].name!.transliteration!.id}', style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 17
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
                surahNumber : ayatNumber,
              ))
              ); // ketika list surah di tekan
            },
            title: Text('${listSurah.data![index].name!.short}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.end,), 
            trailing: CircleAvatar(
              backgroundColor: Color(0xff2EB086),
              child: Text(listSurah.data![index].number.toString(), style: TextStyle(color: Colors.white),),
            ),
          );
        }),
      ) : SizedBox(),
    ) ;
  }
}