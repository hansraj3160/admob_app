import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6578249247215504/2250738674'; // Test ID
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6578249247215504/2250738674'; // Test ID
    }
    throw UnsupportedError('Unsupported platform');
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6578249247215504/6872509961'; // Test ID
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6578249247215504/6872509961'; // Test ID
    }
    throw UnsupportedError('Unsupported platform');
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6578249247215504/9937657001'; // Test ID
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6578249247215504/9937657001'; // Test ID
    }
    throw UnsupportedError('Unsupported platform');
  }

  static Future<void> initialize() async {
    await MobileAds.instance.initialize();
    MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
      testDeviceIds: ['TEST_DEVICE_ID'], // Add your test device IDs
    ));
  }
}