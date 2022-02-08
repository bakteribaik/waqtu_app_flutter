import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:waqtuu/Pages/waqtu_listSurah.dart';
import 'package:waqtuu/Pages/waqtu_shalat.dart';

class homeMenu extends StatefulWidget {
  const homeMenu({ Key? key }) : super(key: key);

  @override
  _homeMenuState createState() => _homeMenuState();
}

class _homeMenuState extends State<homeMenu> {

  bool? internet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('WAQTU', style: TextStyle(fontSize: 14, color: Color(0xff2EB086), fontWeight: FontWeight.bold),),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu), color: Color(0xff2EB086),),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.call), color: Color(0xff2EB086),)
        ],
      ),
      body: SafeArea(
       child: Container(
         width: MediaQuery.of(context).size.width,
         padding: EdgeInsets.all(20),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
              SizedBox(height: 30,),

             Container(
               child: Row(
                 children: [
                   Text('Hello, ', style: TextStyle(color: Colors.grey, fontSize: 30),),
                   SizedBox(),
                   Text('Kamu', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                 ],
               ),
             ),

               SizedBox(height: 30,),

             Container(
               height: MediaQuery.of(context).size.height/2,
               width: MediaQuery.of(context).size.width,
               decoration: BoxDecoration(
                //  color: Colors.red
               ),
               child: Column(
                 children: [
                   Container(
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         InkWell(
                           onTap: () async {
                             if( await Connectivity().checkConnectivity() == ConnectivityResult.wifi || await Connectivity().checkConnectivity() == ConnectivityResult.mobile){
                                Navigator.push(context, 
                                MaterialPageRoute(builder: (context) => const WaqtuHome()));
                             }else{
                               Fluttertoast.showToast(msg: 'No internet Connection', backgroundColor: Color(0xffB8045E), textColor: Colors.white,);
                             }
                           },
                           child:  Container(
                              padding: EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffCDB699),
                              ),
                              child: Column(
                                children: [
                                  Text('Jadwal Shalat', style: TextStyle(color: Colors.white),),
                                  Text('Online', style: TextStyle(color: Colors.white),)
                                ],
                              ),
                          ),
                         ),

                         InkWell(
                           onTap: (){
                              Navigator.push(context, 
                             MaterialPageRoute(builder: (context) => const ListSurahPage()));
                           },
                           child:  Container(
                              padding: EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff2EB086),
                              ),
                              child: Column(
                                children: [
                                  Text("Baca Al'Quran", style: TextStyle(color: Colors.white),),
                                  Text('Offline/Online', style: TextStyle(color: Colors.white),)
                                ],
                              ),
                          ),
                         ),
                       ],
                     ),
                   ),

                    SizedBox(height: 20,),

                   Container(
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         InkWell(
                           onTap: (){},
                           child:  Container(
                              padding: EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                 color: Color(0xffB8405E),
                              ),
                              child: Column(
                                children: [
                                  // Container(child: Icon(Icons.monochrome_photos, color: Colors.white,),),
                                  // SizedBox(height: 10,),
                                  Container(child: Text(' Coming soon', style: TextStyle(color: Colors.white),),),
                                ],
                              ),
                          ),
                         ),

                         InkWell(
                           onTap: (){},
                           child:  Container(
                              padding: EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff313552),),
                              child: Column(
                                children: [
                                  // Container(child: Icon(Icons.monochrome_photos, color: Colors.white,),),
                                  // SizedBox(height: 10,),
                                  Container(child: Text(' Coming soon', style: TextStyle(color: Colors.white),),),
                                ],
                              ),
                          ),
                         ),
                       ],
                     ),
                   ),
                 ],
               ),
             ),

             Center(child: Text('the app developed by Zulfikar Alwi', style: TextStyle(fontSize: 10),),)
           ],
         ),
       ),
      )
    );
  }
}