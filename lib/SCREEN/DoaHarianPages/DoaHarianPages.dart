import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waqtuu/MODELS/DoaSehariHariModel/DoaHarianModel.dart';
import 'package:waqtuu/SERVICE/LocalDataFetch.dart';

class DoaHarianPages extends StatefulWidget {
  const DoaHarianPages({Key? key}) : super(key: key);

  @override
  State<DoaHarianPages> createState() => _DoaHarianPagesState();
}

class _DoaHarianPagesState extends State<DoaHarianPages> {

  DoaHarianModel data = DoaHarianModel();
  LocalData _localData = LocalData();

  List<bool> _isOpen = [];
  bool isFetch = false;

  _getData() async {
    data = await _localData.DoaHarian();
    setState(() {
      isFetch = true;
    });
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
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey
        ),
        backgroundColor: Colors.transparent,
        title: Text('Do`a sehari hari', style: TextStyle(color: Color.fromARGB(255, 50, 172, 111), fontWeight: FontWeight.bold, fontSize: 15),),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(),
            isFetch ?
            Expanded(
              child: Container(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: data.doa!.length,
                  itemBuilder: (context, index) {
                    var doa = data.doa![index];
                    return GestureDetector(
                      onTap: (){
                        HapticFeedback.vibrate();
                        showModalBottomSheet<dynamic>(
                          backgroundColor: Colors.transparent,                                                                
                          context: context, 
                          builder: (context){
                            return FractionallySizedBox(                                                            
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
                                ),
                                child: Wrap(                                                                                                                                                    
                                  direction: Axis.vertical,
                                  runAlignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [                                                                                    
                                    Container(
                                      width: MediaQuery.of(context).size.width/1.1,
                                      height: MediaQuery.of(context).size.height,
                                      padding: EdgeInsets.all(10),
                                      child: SingleChildScrollView(
                                        physics: BouncingScrollPhysics(),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 10,),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.lightBlue[50],
                                                borderRadius: BorderRadius.circular(20)
                                              ),
                                              child: Text('${doa.arab}', textAlign: TextAlign.right, style: TextStyle(fontSize: 24, fontFamily: 'Misbah', height: 2),)
                                            ),
                                            SizedBox(height: 20,),
                                            Text('Latin', style: TextStyle(fontWeight: FontWeight.bold)),
                                            Text('${doa.latin}'),
                                            Divider(),
                                            Text('Arti', style: TextStyle(fontWeight: FontWeight.bold),),
                                            Text('${doa.arti}'),
                                            SizedBox(height: 10,),
                                            Text('Tekan diluar kotak untuk menutup', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 11),)
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 5),
                        padding: EdgeInsets.only(top: 30, bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue[50],
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Column(
                          children: [
                            Text(doa.judul.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),),
                            SizedBox(height: 10,),
                            Text('berdasarkan:',style: TextStyle(fontSize: 10, color: Colors.orange),),
                            Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              child: Text(doa.footnote.toString(),style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.center,)
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              ),
            ) 
            :
            SizedBox()
          ],
        ),
      )
    );
  }
}