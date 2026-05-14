import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/constants/app_colors.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

class ExpenseManagerApp extends StatelessWidget {
  const ExpenseManagerApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Expense Manager',

      debugShowCheckedModeBanner: false,

      // Initial Route
      initialRoute: AppRoutes.splash,

      // App Routes
      getPages: AppPages.routes,

      // Light Theme
      theme: ThemeData(
        useMaterial3: true,

        scaffoldBackgroundColor:
        AppColors.background,

        primaryColor: AppColors.primary,

        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
        ),

        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),

        inputDecorationTheme:
        InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(12),
          ),
        ),
      ),

      // Dark Theme
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),

      // Theme Mode
      themeMode: ThemeMode.system,
    );
  }
}