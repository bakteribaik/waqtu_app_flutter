import 'package:flutter/material.dart';
import 'package:waqtuu/Models/listHadist_model.dart';
import 'package:waqtuu/Pages/hadistPages/specifichadistPage.dart';
import 'package:waqtuu/Service/hadist_service.dart';

class ListHadistPages extends StatefulWidget {
  const ListHadistPages({ Key? key }) : super(key: key);

  @override
  State<ListHadistPages> createState() => _ListHadistPagesState();
}

class _ListHadistPagesState extends State<ListHadistPages> {

  final LColor = Color(0xff01937C);
  final DColor = Color(0xff2C3333);
  final BColor = Color(0xff395B64);

  ListHadistService listHadistService = ListHadistService();
  ListHadist data = ListHadist();

  bool isFetch = false;

  _getData() async {
      data = await listHadistService.fetchData();
      setState(() {});
      isFetch = true;
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Kumpulan Hadist', style: TextStyle(fontSize: 15),),
      ),
      body: SafeArea(
        child: isFetch ? Column(
          children: [
            Expanded(child: Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(top: 30),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
              ),
              child: ListView.builder(
                itemCount: data.data!.length,
                itemBuilder: (context, index){
                  return Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      color: Colors.teal[50],
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: ListTile(
                      onTap: (){
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SpecificHadisPage(
                          id_hadis : data.data![index].id.toString()
                        )));
                      },
                      title: Text('${data.data![index].name}'),
                      subtitle: Text('Total Riwayat Hadist: ${data.data![index].available}', style: TextStyle(fontSize: 13),)
                    ),
                  );
                })
            ))
          ],
        ) : Center(child: CircularProgressIndicator(color: Colors.white,),)
      ),
    );
  }
}