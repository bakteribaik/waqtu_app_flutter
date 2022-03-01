import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111'; //Test ads
      
      //return 'ca-app-pub-8897668405689680/2033801668';
    }else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
     return 'ca-app-pub-3940256099942544/1033173712'; //test ads

     //return 'ca-app-pub-3940256099942544/1033173712';
    }else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917'; //test ads

      // return 'ca-app-pub-8897668405689680/6461299129';
    }else {
      throw new UnsupportedError('Unsupported platform');
    }
  }
}