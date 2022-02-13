import 'package:flutter/material.dart';
import 'package:waqtuu/Models/doa_models.dart';
import 'package:waqtuu/Service/doa_service.dart';
import 'package:waqtuu/Service/surahoffline_service.dart';

class DoaPages extends StatefulWidget {

  final int id;

  const DoaPages({ 
    Key? key,
    required this.id
    }) : super(key: key);

  @override
  _DoaPagesState createState() => _DoaPagesState();
}

class _DoaPagesState extends State<DoaPages> {

  DoaService doaService = DoaService();
  DoaModel data = DoaModel();

  bool isFetch = false;

  _getData() async {
    data = await doaService.getDoa();
    isFetch = true;
    setState(() {});
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
        centerTitle: true,
        title: isFetch ? Text(data.doa![widget.id-1].judul!, style: TextStyle(fontSize: 14),) : Text('Loading...'),
      ),
      body: SafeArea(
        child: isFetch ? Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
            children: [
                SizedBox(height: 30,),
              Text(data.doa![widget.id-1].arab!, style: TextStyle(
                fontSize: 24,
                fontFamily: 'Misbah',
              ),
              textAlign: TextAlign.center,),
                SizedBox(height: 20,),
              Text(data.doa![widget.id-1].latin!, style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,),
                SizedBox(height: 10,),
              Text(data.doa![widget.id-1].arti!, style: TextStyle(
                fontSize: 13,
                color: Colors.grey
              ),
              textAlign: TextAlign.center,),
            ],
          ),
          )
        ) : CircularProgressIndicator(),
      )
    );
  }
}