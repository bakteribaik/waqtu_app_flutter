import 'package:flutter/material.dart';
import 'package:waqtuu/SCREEN/HomePages/HomePages.dart';

void main() async {  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins', backgroundColor: Colors.grey[200]),
      home: HomePages(),
    );
  }
}