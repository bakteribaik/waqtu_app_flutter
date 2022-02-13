import 'package:flutter/material.dart';
import 'package:waqtuu/Models/doa_models.dart';
import 'package:waqtuu/Pages/DoaPages/DoaPages.dart';
import 'package:waqtuu/Service/doa_service.dart';

class DoaHarianPages extends StatefulWidget {
  const DoaHarianPages({ Key? key }) : super(key: key);

  @override
  _DoaHarianPagesState createState() => _DoaHarianPagesState();
}

class _DoaHarianPagesState extends State<DoaHarianPages> {

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
      appBar: AppBar(
        backgroundColor: Color(0xff2EB086),
        title: Text('Doa Sehari Hari'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: GridView.count(
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            crossAxisCount: 2,
            children : List.generate(isFetch ? data.doa!.length : 0, (index){
                return InkWell(
                  onTap: () => {
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => DoaPages(
                      id : data.doa![index].id!
                    )))
                  },
                  child: Container(
                  padding: EdgeInsets.all(10),
                  color: Color(0xff2EB086),
                  child: Center(child: isFetch ? Text(data.doa![index].judul.toString(), textAlign: TextAlign.center, style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),) : SizedBox(),),
                ),
                );
            })
          )
        ),
      )
    );
  }
}