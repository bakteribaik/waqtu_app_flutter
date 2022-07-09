import 'dart:io';

import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:weather/weather.dart';

class WaktuShalat extends StatefulWidget {
  const WaktuShalat({Key? key}) : super(key: key);

  @override
  State<WaktuShalat> createState() => _WaktuShalatState();
}

class _WaktuShalatState extends State<WaktuShalat> {

  WeatherFactory wf = new WeatherFactory("b24f187152d5cec97d6753cf00ee510d", language: Language.INDONESIAN);

  var location  = new Location();
  late LocationData _locationData;

  String cityName = '';
  String WeatherName = '';
  String WeatherIcon = '';
  String WeatherTemp = '';
  String WeatherSpeed = '';
  String WeatherHumidity = '';

  late PrayerTimes _prayerTimes;

  bool getLocation = false;
  bool toogle = false;

  _getPermission() async {
    var _permission = await location.hasPermission();
    var _locationEnabled = await location.serviceEnabled();
      if (_permission == PermissionStatus.denied || _permission == PermissionStatus.deniedForever) {
        _permission = await location.requestPermission();
      }

      if (!_locationEnabled) {
          _locationEnabled = await location.requestService();
      }
    
    if (_locationEnabled == false) {
      Future.delayed(Duration(seconds: 2),(){
        Navigator.of(context).pop();
         Fluttertoast.showToast(msg: 'waktu sholat membutuhkan akses lokasi');
      });
    }else{
      setState(() {});
    }

    _locationData = await location.getLocation();
      if (_locationData != null) {
        var address = await geo.GeocodingPlatform.instance.placemarkFromCoordinates(_locationData.latitude!.toDouble(), _locationData.longitude!.toDouble());
        Weather w = await wf.currentWeatherByLocation(_locationData.latitude!.toDouble(), _locationData.longitude!.toDouble());
        setState(() {
          getLocation = true;
          cityName = address.first.subAdministrativeArea.toString();
          WeatherName = w.weatherDescription.toString();
          WeatherIcon = w.weatherIcon.toString();
          WeatherTemp = w.temperature.toString();
          WeatherSpeed = w.windSpeed.toString();
          WeatherHumidity = w.humidity.toString();
        });

        final myCoordinates = Coordinates(_locationData.latitude!.toDouble(), _locationData.longitude!.toDouble()); // Replace with your own location lat, lng.
        final params = CalculationMethod.karachi.getParameters();
        params.madhab = Madhab.shafi;
        _prayerTimes = PrayerTimes.today(myCoordinates, params);
        print(DateFormat.jm().format(_prayerTimes.asr));
      }
  }

  _checkInternet() async {
    try{
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty) {
        _getPermission();
      }
    }catch (e){
      Fluttertoast.showToast(msg: 'membutuhkan koneksi internet');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkInternet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey
        ),
        backgroundColor: Colors.transparent,
        title: Text('Waktu Shalat', style: TextStyle(color: Color.fromARGB(255, 50, 172, 111), fontWeight: FontWeight.bold, fontSize: 15),),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              getLocation ? 
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_pin, size: 18, color: Colors.red,),
                    Text(cityName, overflow: TextOverflow.ellipsis,),
                  ],
                )
              ) : Text('Loading...'),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
                height: 150,
                width: MediaQuery.of(context).size.width/1.2,
                decoration: BoxDecoration(
                  color: Colors.lightBlue[50],
                  borderRadius: BorderRadius.circular(25)
                ),
                child: getLocation ?  Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Waktu Lokal', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),),
                          StreamBuilder(
                            stream: Stream.periodic(Duration(seconds: 1)),
                            builder: (context, snapshot){
                              return Text(DateFormat('HH:mm').format(DateTime.now()), style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),);
                            },
                          ),
                          GestureDetector(
                            onTap: (){

                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.green[300],
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Text('Laporkan', style: TextStyle(color: Colors.white),),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 10,),

                    
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cuaca Hari ini', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
                            Row(
                              children: [
                                Image(
                                  image: NetworkImage('http://openweathermap.org/img/wn/${WeatherIcon}@2x.png'),
                                  height: 60,
                                ),
                                Text(WeatherTemp)
                              ],
                            ),
                            Text('Nampak ' + WeatherName, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),),
                            Text('Kecepatan angin: ${WeatherSpeed}m/s', style: TextStyle(fontSize: 10, color: Colors.grey),),
                            Text('Kelembaban udara: ${WeatherHumidity}%', style: TextStyle(fontSize: 10, color: Colors.grey),),
                          ],
                        ),
                      ),
                    ),
                  ]
                ) : SizedBox()
              ),

              SizedBox(height: 30,),

              getLocation ?
              Container(
                padding: EdgeInsets.only(left: 35),
                width: MediaQuery.of(context).size.width,
                child: Text('Waktu Sholat', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),)
              ):SizedBox(),
              
              getLocation ?
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                          height: 70,
                          width: MediaQuery.of(context).size.width/1.2,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[50],
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(DateFormat('HH:mm').format(_prayerTimes.fajr), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                                  IconButton(
                                    onPressed: () {
                                      
                                    }, 
                                    icon: Icon(Icons.notifications_outlined)
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/1.2,
                          height: 30,
                          padding: EdgeInsets.only(left: 20, right: 10, top: 5),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[100],
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                          ),
                          child: Text('Subuh', style: TextStyle(),),
                        )
                      ]
                    ), // kontainer waktu 1
                    SizedBox(height: 5,),

                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                          height: 70,
                          width: MediaQuery.of(context).size.width/1.2,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[50],
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(DateFormat('HH:mm').format(_prayerTimes.sunrise), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                                  IconButton(
                                    onPressed: () {
                                      
                                    }, 
                                    icon: Icon(Icons.notifications_outlined)
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/1.2,
                          height: 30,
                          padding: EdgeInsets.only(left: 20, right: 10, top: 5),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[100],
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                          ),
                          child: Text('Matahari terbit', style: TextStyle(),),
                        )
                      ]
                    ), // kontainer waktu 2
                    SizedBox(height: 5,),

                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                          height: 70,
                          width: MediaQuery.of(context).size.width/1.2,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[50],
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(DateFormat('HH:mm').format(_prayerTimes.dhuhr), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                                  IconButton(
                                    onPressed: () {
                                      
                                    }, 
                                    icon: Icon(Icons.notifications_outlined)
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/1.2,
                          height: 30,
                          padding: EdgeInsets.only(left: 20, right: 10, top: 5),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[100],
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                          ),
                          child: Text('Dzuhur', style: TextStyle(),),
                        )
                      ]
                    ), // kontainer waktu 3
                    SizedBox(height: 5,),

                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                          height: 70,
                          width: MediaQuery.of(context).size.width/1.2,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[50],
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(DateFormat('HH:mm').format(_prayerTimes.asr), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                                  IconButton(
                                    onPressed: () {
                                      
                                    }, 
                                    icon: Icon(Icons.notifications_outlined)
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/1.2,
                          height: 30,
                          padding: EdgeInsets.only(left: 20, right: 10, top: 5),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[100],
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                          ),
                          child: Text('Ashar', style: TextStyle(),),
                        )
                      ]
                    ), // kontainer waktu 4
                    SizedBox(height: 5,),

                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                          height: 70,
                          width: MediaQuery.of(context).size.width/1.2,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[50],
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(DateFormat('HH:mm').format(_prayerTimes.maghrib), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                                  IconButton(
                                    onPressed: () {
                                      
                                    }, 
                                    icon: Icon(Icons.notifications_outlined)
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/1.2,
                          height: 30,
                          padding: EdgeInsets.only(left: 20, right: 10, top: 5),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[100],
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                          ),
                          child: Text('Maghrib', style: TextStyle(),),
                        )
                      ]
                    ), // kontainer waktu 5
                    SizedBox(height: 5,),

                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                          height: 70,
                          width: MediaQuery.of(context).size.width/1.2,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[50],
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(DateFormat('HH:mm').format(_prayerTimes.isha), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                                  IconButton(
                                    onPressed: () {
                                      
                                    }, 
                                    icon: Icon(Icons.notifications_outlined)
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/1.2,
                          height: 30,
                          padding: EdgeInsets.only(left: 20, right: 10, top: 5),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[100],
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                          ),
                          child: Text('Isya', style: TextStyle(),),
                        )
                      ]
                    ), // kontainer waktu 6
                    SizedBox(height: 5,)
                  ],
                ),
              )
              : SizedBox(),

              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width/1.1,
                child: Text('data lokasi diambil langsung dari perangkat, waktu sholat yang sudah dikalkulasi sesuai dengan perhitungan dari Universitas ilmu islam dan sesuai lokasi perangkat sekarang', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, color: Colors.grey),)
              )
            ],
          ),
        ),
      ),
    );
  }
}