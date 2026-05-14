import 'package:get/get.dart';

import '../../../data/models/models.dart';
import '../../../data/repositories/expense_repositories.dart';

class AnalyticsController extends GetxController {
  final ExpenseRepository _repository =
  ExpenseRepository();

  RxBool isLoading = false.obs;

  RxList<ExpenseModel> expenses =
      <ExpenseModel>[].obs;

  // Category Totals
  RxMap<String, double> categoryTotals =
      <String, double>{}.obs;

  // Overall Total
  double get totalSpending {
    return categoryTotals.values.fold(
      0.0,
          (sum, amount) => sum + amount,
    );
  }

  @override
  void onInit() {
    super.onInit();

    fetchAnalytics();
  }

  // Fetch Expenses
  Future<void> fetchAnalytics() async {
    try {
      isLoading.value = true;

      final data =
      await _repository.getExpenses();

      expenses.assignAll(data);

      calculateCategoryTotals();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load analytics',
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Calculate Totals
  void calculateCategoryTotals() {
    Map<String, double> totals = {};

    for (var expense in expenses) {
      if (totals.containsKey(
        expense.category,
      )) {
        totals[expense.category] =
            totals[expense.category]! +
                expense.amount;
      } else {
        totals[expense.category] =
            expense.amount;
      }
    }

    categoryTotals.assignAll(totals);
  }
}