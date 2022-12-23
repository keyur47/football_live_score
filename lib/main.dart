import 'dart:async';


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:football_live_score/drawer/RegisterClassses.dart';
// import 'package:football_live_score/firebase_options.dart';
import 'package:football_live_score/helper/shared_preferences.dart';
import 'package:football_live_score/utils/app_colors.dart';
import 'package:football_live_score/utils/firebase_remote_config.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'fifa.dart';
import 'firebase_options.dart';
import 'helper/firebase_analyticsUtils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ClassBuilder.registerClasses();
  await AppPreference.initSharedPreferences();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAnalyticsUtils.init();
  await FirebaseRemoteConfigUtils().initMethod();

  await MobileAds.instance.initialize();
  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //     systemNavigationBarColor: Colors.transparent,
  //     statusBarColor: AppColors.primaryColor,
  //   ),
  // );
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(const FiFa());
}
