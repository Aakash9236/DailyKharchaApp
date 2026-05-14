import 'package:daily_expenses/modules/home/screen/home_screen.dart';
import 'package:get/get.dart';

import '../modules/add/bindings/add_expense_binding.dart';
import '../modules/add/screen/add_screen.dart';
import '../modules/analytics/bindings/analytics_binding.dart';
import '../modules/analytics/screen/analytics_screen.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/screen/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    // Splash
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),

    // Home
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),

    // Add Expense
    GetPage(
      name: AppRoutes.addExpense,
      page: () => const AddExpenseView(),
      binding: AddExpenseBinding(),
    ),

    // Analytics
    GetPage(
      name: AppRoutes.analytics,
      page: () => const AnalyticsView(),
      binding: AnalyticsBinding(),
    ),
  ];
}