import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../routes/app_routes.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() =>
      _SplashViewState();
}

class _SplashViewState
    extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    navigateToHome();
  }

  void navigateToHome() {
    Timer(
      const Duration(seconds: 3),
          () {
        Get.offAllNamed(
          AppRoutes.home,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/animations/expenses.json',
          width: 250,
          height: 250,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}