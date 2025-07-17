import 'package:admob_tutorial_app/service/ad_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdManager {
  InterstitialAd? _interstitialAd;
  bool _isAdLoaded = false;

  void loadAd() {
    InterstitialAd.load(
      adUnitId: AdService.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isAdLoaded = true;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              loadAd(); // Preload next ad
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              loadAd(); // Preload next ad
            },
          );
        },
        onAdFailedToLoad: (error) {
          _isAdLoaded = false;
          // You might want to retry after a delay
        },
      ),
    );
  }

  void showAd() {
    if (_isAdLoaded && _interstitialAd != null) {
      _interstitialAd!.show();
      _isAdLoaded = false;
    } else {
      loadAd();
      // Optionally show a message that ad is loading
    }
  }

  void dispose() {
    _interstitialAd?.dispose();
  }
}