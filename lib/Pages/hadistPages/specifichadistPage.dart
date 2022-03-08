import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waqtuu/Models/specificHadis.dart';
import 'package:waqtuu/Service/hadist_service.dart';

class SpecificHadisPage extends StatefulWidget {

  final String id_hadis;

  const SpecificHadisPage({ Key? key, required this.id_hadis}) : super(key: key);

  @override
  State<SpecificHadisPage> createState() => _SpecificHadisPageState();
}

class _SpecificHadisPageState extends State<SpecificHadisPage> {

  TextEditingController controller = TextEditingController();
  int query = 0;

  bool isFetch = false;
  bool kosong = false;

  specificHadisService service = specificHadisService();
  SpecificHadis data = SpecificHadis();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Hadis Riwayat ${widget.id_hadis}', style: TextStyle(fontSize: 14),),
      ),
      body: Column(
        children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                controller: controller,
                decoration: InputDecoration(
                  icon: Icon(Icons.search_rounded, color: Colors.teal),
                  hintText: 'Masukkan Nomor Hadist',
                  hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  color: Colors.grey
                ),
                onChanged: (q) async{
                  if (q.isNotEmpty) {
                      setState(() {
                        kosong = false;
                      });
                      try {
                        setState(() {
                          query = int.parse(q);
                        });
                      } on FormatException {
                        print('format salah');
                      }
                  } else {
                    setState(() {
                      kosong = true;
                    });
                    print('teksfield kosong');
                  }
                  if (query.runtimeType != String) {
                    if (data != null) {
                        data = await service.fetchData(widget.id_hadis ,query);
                        isFetch = true;
                        setState(() {});
                    } else {
                      print('data tidak ada');
                    }
                  } else {
                    print('data ini string');
                  }
                },
              ),
            ),
            isFetch ?  Expanded(
              child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child:  
                kosong ?Container(
                    color: Colors.white,
                    child: Center(child: FaIcon(FontAwesomeIcons.bookOpen, size: 150, color: Colors.grey[100],)),
                  )
                : ListTile(
                  title: Text('${data.data!.name} No. ${data.data!.contents?.number}', textAlign: TextAlign.center,),
                  subtitle: Column(children: [
                    SizedBox(height: 10,),
                    Expanded(child:  Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text('${data.data!.contents?.id}', textAlign: TextAlign.justify,),
                      ),
                    ))
                  ],),
                )
            )
          ) : Expanded(child: Container(
            color: Colors.white,
            child: Center(child: FaIcon(FontAwesomeIcons.bookOpen, size: 150, color: Colors.grey[100],)),
          ))
        ],
      ),
    );
  }
}

// _onInput(data){
//   return Container(
//     child: Text('${data.}'),
//   );
// }