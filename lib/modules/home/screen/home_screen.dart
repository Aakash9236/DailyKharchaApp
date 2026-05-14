import 'package:daily_expenses/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/empty_widget.dart';
import '../../../core/widgets/loading_widget.dart';
import '../controllers/home_controller.dart';
import '../widgets/expense_card.dart';
import '../widgets/filter_chip.dart';
import '../widgets/total_balance_card.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});

  final List<String> categories = [
    'All',
    'Food',
    'Travel',
    'Shopping',
    'Bills',
    'Health',
    'Entertainment',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Expense Manager'),
        centerTitle: true,

        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(
                AppRoutes.analytics,
              );
            },
            icon: const Icon(
              Icons.pie_chart,
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(
          AppSizes.paddingMD,
        ),
        child: Column(
          children: [
            // Total Card
            Obx(
                  () => TotalBalanceCard(
                totalAmount:
                controller.totalExpense,
              ),
            ),

            const SizedBox(height: 20),

            // Search
            TextField(
              controller:
              controller.searchController,
              onChanged: (value) {
                controller.applyFilters();
              },
              decoration: const InputDecoration(
                hintText: 'Search expenses...',
                prefixIcon: Icon(Icons.search),
              ),
            ),

            const SizedBox(height: 16),

            // Filter Chips
           SizedBox(
             height: 40,
             child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];

                return Obx(
                      () => CategoryFilterChip(
                    label: category,
                    isSelected:
                    controller.selectedCategory.value ==
                        category,
                    onTap: () {
                      controller.changeCategory(
                        category,
                      );
                    },
                  ),
                );
              },
            ),
         ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                final expenses =
                    controller.filteredExpenses;

                if (controller.isLoading.value) {
                  return const LoadingWidget();
                }

                if (expenses.isEmpty) {
                  return const EmptyWidget(
                    message: 'No expenses found',
                  );
                }

                return ListView.builder(
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    final expense = expenses[index];

                    return ExpenseCard(
                      expense: expense,
                      onDelete: () {
                        controller.deleteExpense(
                          expense.id!,
                        );
                      },
                      onEdit: () async {
                        await Get.toNamed(
                          AppRoutes.addExpense,
                          arguments: expense,
                        );
                        controller.fetchExpenses();
                      },
                    );
                  },
                );
              }),
            )
          ],
        ),
      ),

      floatingActionButton:
      FloatingActionButton(
        onPressed: () async {
          await Get.toNamed(
            AppRoutes.addExpense,
          );
          await controller.fetchExpenses();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}