import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigUtils {
  static final FirebaseRemoteConfigUtils _configUtils = FirebaseRemoteConfigUtils._internal();

  factory FirebaseRemoteConfigUtils() {
    return _configUtils;
  }

  FirebaseRemoteConfigUtils._internal();

  static const String bannerAdsAdMob = 'BannerAds_AdMob';
  static const String interstitialAdsAdMob = 'InterstitialAds_AdMob';
  static const String openAdsAdMob = 'OpenAds_AdMob';
  static const String nativeAdsAdMob = 'NativeAds_AdMob';
  static const String imageSliverAppBar = 'Image_Sliver_AppBar';
  static const String iconSliverAppBarColor = 'Icon_Sliver_AppBar_Color';

  static final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  ///

  static String get bannerAdsForAdMob => _remoteConfig.getString(bannerAdsAdMob);
  static String get interstitialAdsForAdMob => _remoteConfig.getString(interstitialAdsAdMob);
  static String get openAdsForAdMob => _remoteConfig.getString(openAdsAdMob);
  static String get nativeAdsForAdMob => _remoteConfig.getString(nativeAdsAdMob);
  static String get imageSliverForAppBar => _remoteConfig.getString(imageSliverAppBar);
  static String get iconSliverAppBarForColor => _remoteConfig.getString(iconSliverAppBarColor);

  Future<void> initMethod() async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
            fetchTimeout: const Duration(seconds: 1), minimumFetchInterval: const Duration(seconds: 0)),
      );
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      print(e);
    }
  }
}
