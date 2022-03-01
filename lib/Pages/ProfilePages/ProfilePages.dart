import 'package:flutter/material.dart';

class ProfilePages extends StatefulWidget {
  const ProfilePages({ Key? key }) : super(key: key);

  @override
  _ProfilePagesState createState() => _ProfilePagesState();
}

class _ProfilePagesState extends State<ProfilePages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('halaman profile'),
        ),
      ),
    );
  }
}