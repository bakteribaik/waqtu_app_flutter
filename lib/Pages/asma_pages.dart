import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waqtuu/Models/asma_models.dart';
import 'package:waqtuu/Service/service_data.dart';

class AsmaPages extends StatefulWidget {

  final isDarkMode;

  const AsmaPages({
    Key? key,
    required this.isDarkMode
    }) : super(key: key);

  @override
  _AsmaPagesState createState() => _AsmaPagesState();
}

class _AsmaPagesState extends State<AsmaPages> {

  AsmaService asmaService = AsmaService();
  AsmaModel x = AsmaModel();

  AudioCache player = AudioCache();

  bool isFetch = false;

  _getData() async {
    x = await asmaService.fetchData();
    setState(() {});
    isFetch = true;
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
  }

  _play(index) async {
    player.play('audio/asma/audio_$index.mp3');
  }

  @override
  Widget build(BuildContext context) {

  final LColor = Color(0xff01937C);
  final DColor = Color(0xff2C3333);
  final BColor = Color(0xff395B64);

    return Scaffold(
      backgroundColor: widget.isDarkMode ? BColor :  Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Asmaul Husna', style: TextStyle(fontSize: 15),),
        elevation: 0.0,
        // actions: [
        //   IconButton(onPressed: (){
        //       showDialog(context: context, 
        //       builder: (BuildContext context){
        //         return AlertDialog(
        //           title: Text('✨\nTernyata kamu bisa mendengarkan asmaul husna dengan mengklik pada namanya loh', style: TextStyle(fontSize: 13), textAlign: TextAlign.center,),
        //           content: Image(
        //             image: AssetImage('assets/gif/fact.gif'),
        //           ),
        //           backgroundColor: Colors.white,
        //           actions: [
        //             TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text('Close'))
        //           ],
        //         );
        //       });
        //   }, icon: FaIcon(FontAwesomeIcons.infoCircle, size: 20,))
        // ],
      ),
      body: SafeArea(
        child: isFetch ? Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: ListView.builder(
            itemCount: x.data!.length,
            itemBuilder: (context, index){
              var data = x.data![index];
              return Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: ListTile(
                  onTap: (){
                    _play(index+1);
                  },
                  leading: Container(
                    width: 80,
                    child: Text('${data.arab}', style: TextStyle(fontFamily: 'Misbah', fontSize: 18, fontWeight: FontWeight.bold),),
                  ),
                  title: Row(children: [
                    Flexible(child: Text('${data.latin}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)))
                  ],),
                  subtitle: Text('${data.arti}' , style: TextStyle(fontSize: 12, color: Colors.grey)),
                  trailing: IconButton(icon: Icon(Icons.play_circle_outline), onPressed: (){
                    _play(index+1);
                  },),
              ),
              );
            }),
        ) : SizedBox()
      ),
    );
  }
}