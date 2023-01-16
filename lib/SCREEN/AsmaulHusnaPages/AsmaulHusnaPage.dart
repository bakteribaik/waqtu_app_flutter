import 'package:flutter/material.dart';
import 'package:waqtuu/MODELS/AsmaulHusnaModel/AsaulHusnaModel.dart';
import 'package:waqtuu/SERVICE/LocalDataFetch.dart';

class AsmaulHusnaPage extends StatefulWidget {
  const AsmaulHusnaPage({Key? key}) : super(key: key);

  @override
  State<AsmaulHusnaPage> createState() => _AsmaulHusnaPageState();
}

class _AsmaulHusnaPageState extends State<AsmaulHusnaPage> {

  LocalData _localData = LocalData();
  AsmaulHusnaModel data = AsmaulHusnaModel();

  bool isFetch = false;

  _getData() async {
    data = await _localData.AsmaulHusna();
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
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey
        ),
        backgroundColor: Colors.transparent,
        title: Text('Asmaul Husna', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 30),
              color: Colors.lightBlue[100],
              child: Column(
                children: [
                  Container(
                    child: Text('Kata Asmaul Husna berasal dari bahasa Arab, yaitu Al-Asmaau yang berarti nama dan Al-Husna yang berparti baik dan indah. Secara istilah Asmaul Husna berarti nama-nama Allah yang indah.',
                    style: TextStyle(color: Colors.black54),
                    textAlign: TextAlign.center,
                    )
                  )
                ],
              ),
            ),
            isFetch ?
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: data.data!.length,
                    itemBuilder: (context, index) {
                      var asma = data.data![index];
                      return Container(
                        padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
                        // color: index.isEven ? Colors.white : Colors.grey[50],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: index.isEven ? Colors.orange[100] : Colors.lightBlue[50]
                                  ),
                                  child: Center(
                                    child: Text('${asma.arab}', overflow: TextOverflow.ellipsis,),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(asma.latin.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                              ],
                            ),
                            Text(asma.arti.toString(), style: TextStyle(fontSize: 13, color: Colors.grey),),
                            Divider()
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
            : SizedBox()
          ],
        ),
      ),
    );
  }
}