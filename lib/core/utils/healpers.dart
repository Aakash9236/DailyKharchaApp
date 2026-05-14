import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class Helpers {
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static Color getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return AppColors.food;

      case 'Travel':
        return AppColors.travel;

      case 'Shopping':
        return AppColors.shopping;

      case 'Bills':
        return AppColors.bills;

      case 'Health':
        return AppColors.health;

      case 'Entertainment':
        return AppColors.entertainment;

      default:
        return AppColors.other;
    }
  }

  static String formatCurrency(double amount) {
    return '₹${amount.toStringAsFixed(2)}';
  }
}