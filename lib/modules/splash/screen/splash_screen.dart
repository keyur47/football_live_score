import 'package:football_live_score/utils/app_colors.dart';
import 'package:football_live_score/utils/size_utils.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [],
      ),
    );
  }
}
