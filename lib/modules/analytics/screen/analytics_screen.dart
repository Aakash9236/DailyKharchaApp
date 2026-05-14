import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/empty_widget.dart';
import '../../../core/widgets/loading_widget.dart';
import '../controllers/analytics_controller.dart';
import '../widgets/analytics_tile.dart';
import '../widgets/pi_chart_widget.dart';

class AnalyticsView
    extends GetView<AnalyticsController> {
  const AnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          AppSizes.paddingMD,
        ),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const LoadingWidget();
          }

          if (controller
              .categoryTotals.isEmpty) {
            return const EmptyWidget(
              message:
              'No analytics data available',
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                // Total Spending
                Text(
                  'Total Spending',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall,
                ),

                const SizedBox(height: 8),

                Text(
                  '₹${controller.totalSpending.toStringAsFixed(2)}',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium,
                ),

                const SizedBox(height: 30),

                // Pie Chart
                PieChartWidget(
                  data:
                  controller.categoryTotals,
                ),

                const SizedBox(height: 30),

                // Category Breakdown
                Text(
                  'Category Breakdown',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall,
                ),

                const SizedBox(height: 20),

                // Tiles
                ListView.builder(
                  itemCount: controller
                      .categoryTotals.length,
                  shrinkWrap: true,
                  physics:
                  const NeverScrollableScrollPhysics(),
                  itemBuilder: (
                      context,
                      index,
                      ) {
                    final entry = controller
                        .categoryTotals
                        .entries
                        .toList()[index];

                    return AnalyticsTile(
                      category: entry.key,
                      amount: entry.value,
                    );
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}