import 'package:flutter/material.dart';
import 'package:waqtuu/Models/doa_models.dart';
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

  _getData() async {
    data = await doaService.getDoa();
    print(data.doa![1].judul);
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
      body: isFetch ? Text('${data.doa![0].judul}') : SizedBox(),
    );
  }
}