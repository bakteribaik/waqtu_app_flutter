import 'package:flutter/material.dart';
import 'package:waqtuu/Models/listSurah_model.dart';
import 'package:waqtuu/Pages/waqtu_surah.dart';
import 'package:waqtuu/Service/listSurah_service.dart';

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

  String ayatNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        centerTitle: true,
        title: Text("Suratul Qur'an", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
        elevation: 0.0,
        backgroundColor: Color(0xff2EB086),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.call),tooltip: 'Need Help?',)
        ],
      ),
      body: isFetch ? Container(
        padding: EdgeInsets.only(left: 18, right: 18),
        child: ListView.builder(
        itemCount: listSurah.data!.length,
        itemBuilder: (context, index){
          return ListTile(
            onTap: (){
              ayatNumber = listSurah.data![index].number.toString();
              
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => SurahPages(
                ayatNumber : ayatNumber,
              ))
              ); // ketika list surah di tekan
            },
            title: Text('${listSurah.data![index].name!.transliteration!.id}'),
            subtitle: Text('${listSurah.data![index].name!.translation!.id}'),
            trailing: Text('${listSurah.data![index].name!.short}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          );
        }),
      ) : SizedBox(),
    ) ;
  }
}