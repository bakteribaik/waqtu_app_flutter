import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:waqtuu/Models/waqtu_model.dart';
import 'package:waqtuu/Pages/LoginPages/Login_Home.dart';
import 'package:waqtuu/Pages/Router/router.dart';
import 'package:waqtuu/Pages/home_menu.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:waqtuu/Service/google_sign_in.dart';
import 'package:waqtuu/Service/service_data.dart';

//Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//ALARM MANAGER
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';





const AndroidNotificationChannel channel = AndroidNotificationChannel( //Flutter_Local_Notification
  'high_importance_channel', //id 
  'High Importance Notification',
  importance: Importance.high,
  playSound: true,
  enableLights: true,
  showBadge: true,
  enableVibration: true,
  sound: RawResourceAndroidNotificationSound('notification.mp3'),
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async{
  await Firebase.initializeApp();
  print('a background message just showedup: ${message.messageId}');
}

Future<void> main() async {
  //Alarm manager initialization
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  //////////////////////////////

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
    .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
    ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true
  );

  //AWESOME NOTIFICATIION

  AwesomeNotifications().initialize(
  // set the icon to null if you want to use the default app icon
  '',
  [
    NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        ledColor: Colors.teal),
  ],
  // Channel groups are only visual and are not required
  channelGroups: [
    NotificationChannelGroup(
        channelGroupkey: 'basic_channel_group',
        channelGroupName: 'Basic group')
  ],
  debug: false
);



  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Future<InitializationStatus> _initGoogleMobileAds(){
    return MobileAds.instance.initialize();
  }

  _getPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
 
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      print('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
     print(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }


  @override
  void initState() {
    super.initState();
    _getPermission();
    // _initGoogleMobileAds();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode, 
          notification.title, 
          notification.body, 
          NotificationDetails(
            android:  AndroidNotificationDetails(
              channel.id,
              channel.name,
              color: Colors.teal,
              playSound: true,
              icon: '@mipmap/ic_launcher',
              sound: RawResourceAndroidNotificationSound('notification'),
            )
          )
       );
      }
    });

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => GoogleSignInProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: homeMenu(),
    ),
  );
}