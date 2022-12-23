import 'dart:developer';

import 'package:football_live_score/utils/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

RxBool isNativeAdsLoaded = false.obs;


class NativeAds extends StatefulWidget {
  const NativeAds({Key? key}) : super(key: key);

  @override
  State<NativeAds> createState() => _NativeAdsState();
}

class _NativeAdsState extends State<NativeAds> {
  late NativeAd _ad;

  @override
  void initState() {
    super.initState();
    loadNativeAd();
  }
  @override
  void dispose() {
    _ad.dispose();
    isNativeAdsLoaded.value = false;
    log("isisNativeAdsLoaded--<${isNativeAdsLoaded.value.toString()}");
    super.dispose();
  }
  void loadNativeAd() {
    // print('NativeAd ads--${AdConstants.bannerAdsId}');

    _ad = NativeAd(
        request: const AdRequest(),

        ///This is a test adUnitId make sure to change it
        // adUnitId: 'ca-app-pub-3940256099942544/2247696110',
        adUnitId: FirebaseRemoteConfigUtils.nativeAdsForAdMob,
        factoryId: 'listTile',
        listener: NativeAdListener(onAdLoaded: (ad) {
          print('NativeAd onAdLoaded--');

          setState(() {
            isNativeAdsLoaded.value = true;
            // isLoaded = AdConstants.isShowNativeAds ;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('failed to load the ad ${error.message}, ${error.code}');
        }));

    _ad.load();
  }

  @override
  Widget build(BuildContext context) {
    return  isNativeAdsLoaded.value
        ? Container(
            child: AdWidget(
              ad: _ad,
            ),
            alignment: Alignment.center,
            height: 90,
            // color: Colors.transparent,
            color: Colors.black12,
          )
        : SizedBox();
  }
}
