import 'package:admob_tutorial_app/widget/banner_ad_widget.dart';
import 'package:admob_tutorial_app/widget/interstitial_ad.dart';
import 'package:admob_tutorial_app/widget/rewarded_ad.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _interstitialAdManager = InterstitialAdManager();
  // Initialize in your state
final _rewardedAdManager = RewardedAdManager();
  @override
  void initState() {
    super.initState();
    _interstitialAdManager.loadAd();
    _rewardedAdManager.dispose();
    _rewardedAdManager.loadAd();
  }

  @override
  void dispose() {
    _interstitialAdManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Column(
        children: [
          Center(child: Text('Welcome to the Home Page!')),
          Column(
            children: [
              
// Show ad when needed
ElevatedButton(
  onPressed: () {
    _rewardedAdManager.showAd(
      onRewardEarned: (reward) {
        // Handle reward
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You earned ${reward.amount} ${reward.type}')),
        );
      },
      onAdFailedToShow: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ad failed to show: $error')),
        );
      },
    );
  },
  child: const Text('Show Rewarded Ad'),
),
              SizedBox(height: 20),
              // Your content
              ElevatedButton(
  onPressed: () {
    _interstitialAdManager.showAd();
    // Your button action
  },
  child: const Text('Show Interstitial Ad'),
),
              const SizedBox(height: 20),
              const BannerAdWidget(),
            ],
          ),
        ],
      ),
    );
  }
}
