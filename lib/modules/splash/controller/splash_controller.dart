import 'package:football_live_score/ads/interstitial_ad.dart';
import 'package:football_live_score/ads/open_ad.dart';
import 'package:football_live_score/utils/navigation_utils/navigation.dart';
import 'package:football_live_score/utils/navigation_utils/routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    AppOpenAdManager.loadAd();
    InterstitalAd.createInterstitialAd();
    await Future.delayed(
      const Duration(seconds: 0),
    );
    // AppSharedPreference.userToken == null ?
    // Navigation.popAndPushNamed(Routes.signInScreen);:
    Navigation.popAndPushNamed(Routes.drawerScreen);
  }
}
