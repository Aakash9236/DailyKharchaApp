import 'package:flutter/material.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/healpers.dart';


class AnalyticsTile extends StatelessWidget {
  final String category;
  final double amount;

  const AnalyticsTile({
    super.key,
    required this.category,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: AppSizes.paddingMD,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
          Helpers.getCategoryColor(
            category,
          ),
        ),
        title: Text(category),
        trailing: Text(
          Helpers.formatCurrency(amount),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}