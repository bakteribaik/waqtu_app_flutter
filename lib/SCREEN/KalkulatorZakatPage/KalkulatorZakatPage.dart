import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class KalkulatorZakatPage extends StatefulWidget {
  const KalkulatorZakatPage({Key? key}) : super(key: key);

  @override
  State<KalkulatorZakatPage> createState() => _KalkulatorZakatPageState();
}

class _KalkulatorZakatPageState extends State<KalkulatorZakatPage> {

  TextEditingController _penghasilan = TextEditingController();
  TextEditingController _bonus = TextEditingController();

  int Hasil = 0;

  _kalkulasi(){
    if (_penghasilan.text.isNotEmpty && _bonus.text.isNotEmpty) {
      setState(() {
        Hasil = (int.parse(_penghasilan.text) + int.parse(_bonus.text)).toInt();
      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mohon isi kolom dengan benar!'))
      );
    }
  }

  _tampilNilai(){
    print(Hasil);
    if (Hasil <= 6644868) {
      showDialog(
        context: context, 
        builder: (context){
          return AlertDialog(
            title: Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.red[300]
              ),
              child: Text('Pendapatan anda belum mencapai nilai Nishab', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 14),),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Jumlah zakat penghasilan anda:', style: TextStyle(fontSize: 13),),
                SizedBox(height: 10,),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Text('Rp. 0,-', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
                ),
                SizedBox(height: 20,),
                Text('Hitungan ini berdasarkan rumus dari Badan Amil Zakat Nasional (BAZNAS)', style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.center,),
              ],
            ),
          );
        }
      );
    }else{
      var Zakat = (Hasil * 0.025).toInt();
      showDialog(
        context: context, 
        builder: (context){
          return AlertDialog(
            title: Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.green
              ),
              child: Text('Pendapatan anda mencapai nilai Nishab', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 14),),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Jumlah zakat penghasilan anda:', style: TextStyle(fontSize: 13),),
                SizedBox(height: 10,),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Text('${NumberFormat.currency(locale: 'id', symbol: 'Rp. ').format(Zakat)}', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
                ),
                SizedBox(height: 20,),
                Text('Hitungan ini berdasarkan rumus dari Badan Amil Zakat Nasional (BAZNAS)', style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.center,),
              ],
            ),
          );
        }
      );
    }
  }

  _Hitung(){
    _kalkulasi();
    if(Hasil != 0 && _penghasilan.text != '' || _bonus.text != ''){
      _tampilNilai();
    }
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
        title: Text('Kalkulator Zakat', style: TextStyle(color: Color.fromARGB(255, 50, 172, 111), fontWeight: FontWeight.bold, fontSize: 15),),
      ),
      body: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: Container(
          color: Colors.transparent,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Kalkulator Zakat\nPenghasilan', style: TextStyle(fontSize: 25, color: Colors.black54, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width/1.2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: TextField(
                  controller: _penghasilan,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text('Masukkan penghasilan/bulan'),
                    labelStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width/1.2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: TextField(
                  controller: _bonus,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text('Bonus/THR/Lainnya..'),
                    labelStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none
                  ),
                ),
              ),
              SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  HapticFeedback.vibrate();
                  _Hitung();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: MediaQuery.of(context).size.width/1.8,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[200],
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Text('Hitung', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}