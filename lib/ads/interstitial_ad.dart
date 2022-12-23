import 'dart:developer';
import 'dart:io';

import 'package:football_live_score/utils/firebase_remote_config.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitalAd {
  static InterstitialAd? _interstitialAd;
  static int maxFailedLoadAttempts = 3;
  static int _numInterstitialLoadAttempts = 0;

  // static final String appInterstitialId =
  //     FirebaseRemoteConfigUtils.appInterstitialId;
  // static final String iosInterstitialId =
  //     FirebaseRemoteConfigUtils.iosInterstitialId;
  static const AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  static Future<void> createInterstitialAd() async {
    await InterstitialAd.load(
      // adUnitId: "",

      /// live id
      adUnitId: FirebaseRemoteConfigUtils.interstitialAdsForAdMob,

      /// test id
      // adUnitId: "ca-app-pub-3940256099942544/1033173712",

      request: request,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          log('$ad loaded');
          _interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          _interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          log('InterstitialAd failed to load: $error.');
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
            createInterstitialAd();
          }
        },
      ),
    );
  }

  static void showInterstitialAd() {
    if (_interstitialAd == null) {
      log('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {
        log('ad onAdShowedFullScreenContent.');
      },
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        log('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        log('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }
}
