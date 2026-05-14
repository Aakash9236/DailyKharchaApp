import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class EmptyWidget extends StatelessWidget {
  final String message;

  const EmptyWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long,
            size: 80,
            color: AppColors.textSecondary.withOpacity(0.5),
          ),
          const SizedBox(height: AppSizes.paddingMD),
          Text(
            message,
            style: const TextStyle(
              fontSize: AppSizes.textLG,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}