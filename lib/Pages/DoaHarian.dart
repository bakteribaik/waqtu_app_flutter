import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:waqtuu/Models/doa_models.dart';
import 'package:waqtuu/Pages/DoaPages/DoaPages.dart';
import 'package:waqtuu/Service/doa_service.dart';

class DoaHarianPages extends StatefulWidget {

  final isDarkMode;
  const DoaHarianPages({ Key? key,
  required this.isDarkMode }) : super(key: key);

  @override
  _DoaHarianPagesState createState() => _DoaHarianPagesState();
}

class _DoaHarianPagesState extends State<DoaHarianPages> {

  final LColor = Color(0xff01937C);
  final DColor = Color(0xff2C3333);
  final BColor = Color(0xff395B64);

  DoaService doaService = DoaService();
  DoaModel data = DoaModel();

  bool isFetch = false;

  int id = 0;

  _getData() async {
    data = await doaService.getDoa();
    setState(() {});
    isFetch = true;
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode? BColor : Colors.teal,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text('Doa Sehari Hari', style: TextStyle(fontSize: 15),),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: GridView.count(
            crossAxisSpacing: 5,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children : List.generate(isFetch ? data.doa!.length : 0, (index){
                return InkWell(
                  onTap: () => {
                    AudioCache().play('audio/sfx/click_sound.mp3'),
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => DoaPages(
                      isDarkMode : widget.isDarkMode,
                      id : data.doa![index].id!
                    )))
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: widget.isDarkMode? DColor : Colors.white,
                    ),
                    child: Center(child: isFetch ? Text(data.doa![index].judul.toString(), textAlign: TextAlign.center, style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: widget.isDarkMode? Colors.white : Colors.teal
                    ),) : SizedBox(),),
                  ),
                  )
                );
            })
          )
        ),
      )
    );
  }
}