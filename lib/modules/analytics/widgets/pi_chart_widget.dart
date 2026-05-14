import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/healpers.dart';

class PieChartWidget extends StatelessWidget {
  final Map<String, double> data;

  const PieChartWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: PieChart(
        PieChartData(
          sections: data.entries.map(
                (entry) {
              return PieChartSectionData(
                value: entry.value,
                title:
                '${entry.key}\n₹${entry.value.toStringAsFixed(0)}',
                radius: 90,
                color:
                Helpers.getCategoryColor(
                  entry.key,
                ),
                titleStyle:
                const TextStyle(
                  color: Colors.white,
                  fontWeight:
                  FontWeight.bold,
                  fontSize: 12,
                ),
              );
            },
          ).toList(),
          sectionsSpace: 2,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }
}