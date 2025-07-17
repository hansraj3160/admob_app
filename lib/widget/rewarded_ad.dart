import 'package:admob_tutorial_app/service/ad_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardedAdManager {
  RewardedAd? _rewardedAd;
  bool _isAdLoaded = false;

  void loadAd() {
    RewardedAd.load(
      adUnitId: AdService.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
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

  void showAd({
    required Function(RewardItem) onRewardEarned,
    Function()? onAdShowed,
    Function(String)? onAdFailedToShow,
  }) {
    if (_isAdLoaded && _rewardedAd != null) {
      _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          onRewardEarned(reward);
        },
      );
      onAdShowed?.call();
      _isAdLoaded = false;
    } else {
      loadAd();
      onAdFailedToShow?.call('Ad not loaded yet');
    }
  }

  void dispose() {
    _rewardedAd?.dispose();
  }
}