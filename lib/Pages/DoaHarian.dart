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
        child: isFetch ? Container(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: data.doa!.length,
            itemBuilder: (context, index){
              var x = data.doa![index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DoaPages(id: x.id!, isDarkMode: widget.isDarkMode)));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 5),
                  padding: EdgeInsets.only(bottom: 30, top: 30, left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text('${x.judul}'),
                ),
              );
            })
        ) : CircularProgressIndicator(),
      )
    );
  }
}