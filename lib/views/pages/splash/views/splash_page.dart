import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reminder/app/routes/routing_service.dart';
import 'package:reminder/shared/constant/constant.dart';
import 'package:reminder/shared/extensions/extensions.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();

  static const String route = '/';
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      RoutingService.navigateToRemindersPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10.w),
          width: 140.w,
          decoration: BoxDecoration(
            color: context.colorScheme.secondary.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Image.asset(AppAssets.splash),
        ),
      ),
    );
  }
}
