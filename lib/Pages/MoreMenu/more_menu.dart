import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waqtuu/Pages/hadistPages/listhadist.dart';

class MoreMenuPage extends StatelessWidget {
  const MoreMenuPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

  final LColor = Color(0xff01937C);
  final DColor = Color(0xff2C3333);
  final BColor = Color(0xff395B64);
    
    bool isTap = false;

    return Scaffold(
      backgroundColor: LColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text('Menu Lainnya', style: TextStyle(fontSize: 13),),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
          ),
          padding: EdgeInsets.all(20),
          child: Column(children: [
            GestureDetector(
              onTap: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => ListHadistPages()));
              },
                child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Kumpulan Hadist', style: TextStyle(color: Colors.black),)
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                print('taptap');
              },
                child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Coming soon', style: TextStyle(color: Colors.grey),)
                  ],
                ),
              ),
            ),
          ],

        ),
       ),
      )
    );
  }
}